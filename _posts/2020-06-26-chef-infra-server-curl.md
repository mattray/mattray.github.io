---
title: Uploading Data Bags to Chef Infra Server with knife, knife raw, and curl
---

<a href="https://github.com/chef/chef"><img src="/assets/chef-logo.png" alt="Chef" width="100" height="100" align="right" /></a>

The [Chef Infra Server API](https://docs.chef.io/api_chef_server/) is fairly well-documented and includes many examples. [Data bags](https://docs.chef.io/data_bags/) are a way to store JSON on the Chef Infra Server. The customer I'm working with needed an example of uploading data bags via the API because they wanted to upload JSON into them without using the CLI `knife` tool from ServiceNow. While there are supported [Ruby](https://github.com/chef/chef-api) and [Go](https://github.com/chef/go-chef) Chef Server APIs available, they wanted a `curl` example. This post covers locking down a set of credential and progressing from the `knife` CLI to using `curl`.

# Chef Server Preparation

In order to interact with the API, we will need a client key with permissions limited to working with data bags. These commands must be run on the Chef Server. First, we'll create the organization for testing:

```
chef-server-ctl org-create test1 'Test Organization 1' -f test1-validator.pem
```

Because I'm using a self-signed certificate and not every `knife` subcommand takes `--node-ssl-verify-mode`, I have this additional `no_ssl.rb` configuration file. You may not need this step if you have a proper certificate.
```
ssl_verify_mode :verify_none
```

## Create the data bag manager client

Next we need to create a `dbm` data bag manager client that manage data bags.
```
knife client create dbm -f dbm.pem -k /etc/opscode/pivotal.pem -u pivotal -s "https://localhost/organizations/test1" -c no_ssl.rb --disable-editing
```

## Grant data bag permissions
```
knife acl add client dbm containers data create,read,update,delete -k /etc/opscode/pivotal.pem -u pivotal -s "https://localhost/organizations/test1" -c no_ssl.rb
```

We're now done with this organization on the Chef Infra Server. Copy the the `dbm.pem` off the Chef Infra Server to the destination.

## Reusing the dbm client across multiple organizations

Having a `dbm` client for managing data bags within a particular organization is useful, but if you had a large number of organizations you'd probably prefer to reuse that client across them. `knife client create` will allow you to provide your own public key, so the following can be used to create the public key from the generated private key, then reuse it for additional organizations (in our case `test2`).
```
chef-server-ctl list-client-keys test1 dbm -v | tail -10 > dbm.pub
knife client create dbm --public-key dbm.pub -k /etc/opscode/pivotal.pem -u pivotal -s "https://localhost/organizations/test2" -c no_ssl.rb --disable-editing
```

From here out, the rest of the commands with the `dbm` client would be the same, replacing `test1` with `test2` or similar for your other organizations.

# Using knife

If we have access to a CLI, the easiest way to manage data bags would be to use `knife data bag`. We could create the data bag `srs`
```
knife data bag create srs -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
```
Upload an item (defined in a `data_bags/srs/h.json`) file.
```
$ cat data_bags/srs/h.json
{
    "id": "hyperchicken",
    "payload": {
        "one": "1"
    }
}
$ knife data bag from file srs h.json -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
Updated data_bag_item[srs::hyperchicken]
```

We can also list, show and delete the items.
```
$ knife data bag list -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
srs
$ knife data bag show srs hyperchicken -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
id:      hyperchicken
payload:
  one:   1
$ knife data bag delete srs -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb -y
Deleted data_bag[srs]
```

# knife raw

The [knife raw](https://docs.chef.io/workstation/knife_raw/) command allows us to pass straight JSON to API endpoints with the `knife` CLI handling authentication. Here are examples of how to create the `srs` data bag

```
$ echo '{ "name":"srs" }' > srs.json
$ knife raw -m POST /data -i srs.json -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
{
  "uri": "https://ndnd/organizations/test1/data/srs"
}
$ knife data bag list -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
srs
```
Create and view the `hyperchicken` item
```
$ knife raw -m POST /data/srs -i data_bags/srs/h.json -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
{
  "id": "hyperchicken",
  "payload": {
    "one": "1"
  },
  "chef_type": "data_bag_item",
  "data_bag": "srs"
}
$ knife data bag show srs hyperchicken -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
id:      hyperchicken
payload:
  one:   1
```
and we can delete the data bag item and entire data bag
```
$ knife raw -m DELETE /data/srs/hyperchicken -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
{
  "name": "data_bag_item_srs_hyperchicken",
  "json_class": "Chef::DataBagItem",
  "chef_type": "data_bag_item",
  "data_bag": "srs",
  "raw_data": {
    "id": "hyperchicken",
    "payload": {
      "one": "1"
    }
  }
}
$ knife data bag show srs -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb

$ knife raw -m DELETE /data/srs -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb
{
  "name": "srs",
  "json_class": "Chef::DataBag",
  "chef_type": "data_bag"
}
$ knife data bag list -k dbm.pem -u dbm -s "https://ndnd/organizations/test1" -c no_ssl.rb

```

# curl
