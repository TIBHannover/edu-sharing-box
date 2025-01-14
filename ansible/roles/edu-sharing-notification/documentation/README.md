# Ansible Role: edu-sharing-notification

The `edu-sharing-notification` role is used activate/deactivate notification system for edu-sharing

## Implementation

The `edu-sharing-notification` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-notification
      tags: 
        - edu-sharing-notification

```

or we just want to run only the `edu-sharing-notification` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-notification"
```
This will skip other roles and run only the edu-sharing-notification role

## Role Variables

The `edu-sharing-notification` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
search_elastics_environment_variable:
  - key: REPOSITORY_SEARCH_ELASTIC_INDEX_JAVA_XMS
    value: '{{repository_search_elastic_index_java_xms | default("1g",true)}}'
```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `config-env.yml`: Used to update the .env file with rendering service variables


## Cleaning elastics search

sometimes we need to clear the elastics search indexing, so the elastics search will re-index everything again, this may happen when we want to restore data from backup, or when something went wrong with elastics search, or what ever the problem may be.

in order to reset the elastics search you can add the into the `--tags` another tags called `edu-sharing-notification-reset`

example:

```sh
  ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-notification,edu-sharing-notification-reset"

```
in this case the ansible will run the reset elastics search index and then restart it again.