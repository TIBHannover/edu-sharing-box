# Ansible Role: edu-sharing-search-elastic

The `edu-sharing-search-elastic` role is used update the repository search elastic.

## Implementation

The `edu-sharing-search-elastic` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-search-elastic
      tags: 
        - edu-sharing-search-elastic

```

or we just want to run only the `edu-sharing-search-elastic` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-search-elastic"
```
This will skip other roles and run only the edu-sharing-search-elastic role

## Role Variables

The `edu-sharing-search-elastic` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
search_elastics_environment_variable:
  - key: REPOSITORY_SEARCH_ELASTIC_INDEX_JAVA_XMS
    value: '{{repository_search_elastic_index_java_xms | default("1g",true)}}'
  - key: REPOSITORY_SEARCH_ELASTIC_INDEX_JAVA_XMX
    value: '{{repository_search_elastic_index_java_xmx | default("1g",true)}}'
  - key: REPOSITORY_SEARCH_ELASTIC_INDEX_REPLICAS
    value: '{{repository_search_elastic_index_replicas | default("1",true)}}'
  - key: REPOSITORY_SEARCH_ELASTIC_INDEX_SHARDS
    value: '{{repository_search_elastic_index_shards | default("1",true)}}'
  - key: REPOSITORY_SEARCH_ELASTIC_TRACKER_JAVA_XMS
    value: '{{repository_search_elastic_tracker_java_xms | default("1g",true)}}'
  - key:  REPOSITORY_SEARCH_ELASTIC_TRACKER_JAVA_XMX
    value: '{{repository_search_elastic_tracker_java_xmx| default("1g",true)}}'


```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `config-env.yml`: Used to update the .env file with rendering service variables


## Cleaning solr4

sometimes we need to clear the elastics search indexing, so the elastics search will re-index everything again, this may happen when we want to restore data from backup, or when something went wrong with elastics search, or what ever the problem may be.

in order to reset the elastics search you can add the into the `--tags` another tags called `edu-sharing-search-elastic-reset`

example:

```sh
  ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-search-elastic,edu-sharing-search-elastic-reset"

```
in this case the ansible will run the reset elastics search index and then restart it again.