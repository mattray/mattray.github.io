---
title: Minimal Access Controls for Uploading Cookbooks to a Chef Infra Server
---

<a href="https://github.com/chef/chef"><img src="/assets/chef-logo.png" alt="Chef" width="100" height="100" align="right" /></a>

The CI/CD system I was working with needed to have a temporary user with limited permissions for uploading cookbooks. While Chef Infra Server has extensive access controls, the [knife-acl](https://github.com/chef-boneyard/knife-acl) documentation didn't provide an example of what I needed, so I'm documenting it here.

## Chef Server Preparation

These commands must be run on the Chef Server. Create the organization for testing:

```
chef-server-ctl org-create test1 'Test Organization 1' -f test1-validator.pem
```

Create a `meta-user` who will have permissions to manage the clients being created/deleted for cookbook uploading and add them as an administrator to the organization:

```
chef-server-ctl user-create meta-user Meta User meta-user@mattray.dev meta-user -f meta-user.pem
chef-server-ctl org-user-add test1 meta-user -a
```

Copy the `meta-user.pem` credentials off the Chef Server. Because I'm using a self-signed certificate and not every `knife` subcommand takes `--node-ssl-verify-mode`, I have this additional `no_ssl.rb` configuration file.

```
ssl_verify_mode :verify_none
```

## Create a cookbook-uploader Group

A group is used to define access to objects in the Chef Infra Server. I'm using a `cookbook-uploader` group to isolate client privileges.

```
knife group create cookbook-uploader --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" --disable-editing -c no_ssl.rb
```

I want to restrict the permissions for this group to only allow uploading a cookbook. This requires `create` and `read` permissions on the `cookbooks` container and `create` on the `sandboxes` container for uploading.

```
knife acl add group cookbook-uploader containers cookbooks create --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" --disable-editing -c no_ssl.rb
knife acl add group cookbook-uploader containers cookbooks read --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" --disable-editing -c no_ssl.rb
knife acl add group cookbook-uploader containers sandboxes create --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" --disable-editing -c no_ssl.rb
```

You can verify these permissions with the following (note the `cookbook-uploader`):

```
$ knife acl show containers cookbooks --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" --disable-editing -c no_ssl.rb
create:
  clients:
  groups:
    admins
    cookbook-uploader
    users
  users:   pivotal
delete:
  clients:
  groups:
    admins
    users
  users:   pivotal
grant:
  clients:
  groups:  admins
  users:   pivotal
read:
  clients:
  groups:
    admins
    clients
    cookbook-uploader
    users
  users:   pivotal
update:
  clients:
  groups:
    admins
    users
  users:   pivotal
```

## Create the client

Rather than have a permanent user for managing uploads, I'm going to create a temporary client.

```
$ knife client create upload1 -f upload1.pem --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb --disable-editing
Created client[upload1]
```

Add the client to `cookbook-uploader` group.

```
$ knife group add client upload1 cookbook-uploader --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb
Adding 'upload1' to 'cookbook-uploader' group
```

Because I wanted limited permissions on the client, I'll remove the client from the `clients` group.

```
$ knife group remove client upload1 clients --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb
Removing 'upload1' from 'clients' group
```

In order to verify that the client is part of the `cookbook-uploader` group and that they are no longer in clients group.

```
$ knife group show cookbook-uploader --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb
actors:    upload1
clients:   upload1
groupname: cookbook-uploader
groups:
name:      cookbook-uploader
orgname:   test1
users:
$ knife group show clients --key meta-user.pem --user meta-user --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb
actors:    test1-validator
clients:   test1-validator
groupname: clients
groups:
name:      clients
orgname:   test1
users:
```

## Upload a Cookbook

Now that the temporary user is in place, they can upload the cookbook.

```
$ knife cookbook upload example -o cookbooks --key upload1.pem --user upload1 --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb
Uploading example [0.1.0]
Uploaded 1 cookbook.
```

This user has permission to list cookbooks, but not view any others that were not created by .

```
$ knife cookbook list --key upload1.pem --user upload1 --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb
example  0.1.0
toml     0.1.1
$ knife cookbook show toml 0.1.1 --key upload1.pem --user upload1 --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb
ERROR: You authenticated successfully to https://ndnd/organizations/test1 as upload1 but you are not authorized for this action.
Response:  missing read permission
```

## Delete the client

Once the CI/CD has finished uploading the cookbook, the client can be deleted.

```
knife client delete upload1 --key upload1.pem --user upload1 --server-url "https://CHEFINFRASERVER/organizations/test1" -c no_ssl.rb -y
Deleted client[upload1]
```
