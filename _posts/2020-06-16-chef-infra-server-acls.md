---
title: Minimal Access Controls for Uploading Cookbooks to a Chef Infra Server (Updated)
---

<a href="https://github.com/chef/chef"><img src="/assets/chef-logo.png" alt="Chef" width="100" height="100" align="right" /></a>

Update: I needed to further restrict the permissions so I've rewritten this post.

The CI/CD system I was working with needed to have a temporary client with limited permissions for uploading cookbooks. While Chef Infra Server has extensive access controls, the [knife-acl](https://github.com/chef-boneyard/knife-acl) documentation didn't provide an example of what I needed, so I'm documenting it here.

## Chef Server Preparation

These commands must be run on the Chef Server. First, we'll create the organization for testing:
```
chef-server-ctl org-create test1 'Test Organization 1' -f test1-validator.pem
```

Because I'm using a self-signed certificate and not every `knife` subcommand takes `--node-ssl-verify-mode`, I have this additional `no_ssl.rb` configuration file. You may not need this step if you have a proper certificate.
```
ssl_verify_mode :verify_none
```

### Create a cookbook-uploader Group

A group is used to define access to objects in the Chef Infra Server. We will do this from the Chef Server with the `pivotal` superadmin user. I want to restrict the permissions for this group to only allow uploading a cookbook. We will create a `cookbook-uploader` group that will have permissions for cookbook uploading but nothing else. This requires `create` permissions on the `cookbooks` container and `create` on the `sandboxes` container for uploading.
```
knife group create cookbook-uploader --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" --disable-editing -c no_ssl.rb
knife acl add group cookbook-uploader containers cookbooks create --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
knife acl add group cookbook-uploader containers sandboxes create --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
```

You can verify these permissions with the following (note the `cookbook-uploader`):
```
$ knife acl show containers cookbooks --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
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
    users
  users:   pivotal
update:
  clients:
  groups:
    admins
    users
  users:   pivotal
```

### Create the cookbook client creator client

Next we need to create a `cccc` client that can create other clients.
```
knife client create cccc -f cccc.pem --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb --disable-editing
knife acl add client cccc containers clients create --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
```

The `cccc` client can add clients to the cookbook-uploader group.
```
knife acl add client cccc groups cookbook-uploader read --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
knife acl add client cccc groups cookbook-uploader update --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
```

We're now done with this organization on the Chef Infra Server. Copy the the `cccc.pem` off the Chef Infra Server as necessary.

## Create the upload client

Now that `cccc` can make clients and add them to `cookbook-uploader` group, we will use this to create new clients for uploading. Rather than have a permanent user for managing uploads, I'm going to create a temporary client.
```
$ knife client create upload1 -f upload1.pem --key cccc.pem --user cccc --server-url "https://ndnd/organizations/test1" -c no_ssl.rb --disable-editing
Created client[upload1]
```

Add the client to `cookbook-uploader` group.
```
$ knife group add client upload1 cookbook-uploader --key cccc.pem --user cccc --server-url "https://ndnd/organizations/test1" -c no_ssl.rb
Adding 'upload1' to 'cookbook-uploader' group
```

We can verify that the client is part of the `cookbook-uploader` group.
```
$ knife group show cookbook-uploader --key cccc.pem --user cccc --server-url "https://ndnd/organizations/test1" -c no_ssl.rb
actors:    upload1
clients:   upload1
groupname: cookbook-uploader
groups:
name:      cookbook-uploader
orgname:   test1
users:
```

## Upload a Cookbook

Now that the temporary user is in place, they can upload the cookbook.
```
$ knife cookbook upload apt -o cookbooks --key upload1.pem --user upload1 --server-url "https://ndnd/organizations/test1" -c no_ssl.rb
Uploading apt          [7.3.0]
Uploaded 1 cookbook.
```

This user has permission to list cookbooks, but not view any others that were not created by .
```
$ knife cookbook list --key upload1.pem --user upload1 --server-url "https://ndnd/organizations/test1" -c no_ssl.rb
apt     7.3.0
```

## Delete the client

Once the CI/CD has finished uploading the cookbook, the client can be deleted.

```
$ knife client delete upload1 --key upload1.pem --user upload1 --server-url "https://ndnd/organizations/test1" -c no_ssl.rb -y
Deleted client[upload1]
```

## Verifying on the Chef Infra Server

If you need to look at the clients and groups on the Chef Infra Server:
```
knife client list --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
knife group list --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
knife group show cookbook-uploader --key /etc/opscode/pivotal.pem --user pivotal --server-url "https://localhost/organizations/test1" -c no_ssl.rb
```
