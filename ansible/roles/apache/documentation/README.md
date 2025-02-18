# Ansible Role: apache

The `apache` role is used install and update the apache web server

## Implementation

The `apache` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
  - role: apache
    tags: 
      - apache

```
or we just want to run only the `apache` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "apache"
```
This will skip other roles and run only the apache role

## Role Variables

The `apache` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
---
apache2_modules:
  - rewrite
  - headers
  - proxy
  - proxy_ajp
  - proxy_http
apache2_conf_templates: # list of all templates that should be installed in sites-available/sites-enabled. Required for each entry: 'name', 'path'
  - name: edu-sharing
    path: apache_vhost.conf.j2 # path to the apache-conf-template. you could use your custom template here
 
```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task in which we install and add configuration for apache.


## Templates

The `template/` directory contains template files.

1. `apache_vhost.conf.j2`: a template file,with default configuration

## handlers

The `handlers/` directory contains handlers for apache that run when a change is made to to this role.
