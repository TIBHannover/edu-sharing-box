# Ansible Role: edu-sharing-search-solr

The `edu-sharing-search-solr` role is used update the repository search solr.

## Implementation

The `edu-sharing-search-solr` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-search-solr
      tags: 
        - edu-sharing-search-solr

```

or we just want to run only the `edu-sharing-search-solr` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-search-solr"
```
This will skip other roles and run only the edu-sharing-search-solr role

## Role Variables

The `edu-sharing-search-solr` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
search_solr_environment_variable:
  - key: REPOSITORY_SEARCH_SOLR4_JAVA_XMS
    value: '{{repository_search_solr_java_xms | default("1g",true)}}'
  - key: REPOSITORY_SEARCH_SOLR4_JAVA_XMX
    value: '{{repository_search_solr_java_xmx | default("1g",true)}}'

  # If we need to override the service name, then we can override it,
  # example:  in the edu-sharing-init/vars/versions/8.1.0.yml we add this variable with new value
  service_repository_search_solr:  'repository-search-solr4'

```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `config-env.yml`: Used to update the .env file with rendering service variables

## Cleaning solr4

sometimes we need to clear the solr indexing, so the solr will re-index everything again, this may happen when we want to restore data from backup, or when something went wrong with solr, or what ever the problem may be.

in order to reset the solr you can add the into the `--tags` another tags called `edu-sharing-search-solr-reset`

example:

```sh
  ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-search-solr,edu-sharing-search-solr-reset"

```
in this case the ansible will run the reset solr index and then restart the solr service again.

