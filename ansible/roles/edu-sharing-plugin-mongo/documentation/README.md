# Ansible Role: edu-sharing-plugin-mongo

The `edu-sharing-plugin-mongo` role is used activate/deactivate mongo plugin which is used for relations

## Implementation

The `edu-sharing-plugin-mongo` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
  - role: edu-sharing-plugin-mongo
    tags: 
      - edu-sharing-plugin-mongo

```

> `edu-sharing-plugin-mongo` is not activated by default, to activate make `enable_plugin_mongo_service: false`

or we just want to run only the `edu-sharing-plugin-mongo` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-plugin-mongo"
```
This will skip other roles and run only the edu-sharing-plugin-mongo role

## Role Variables

The `edu-sharing-plugin-mongo` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
---
enable_plugin_mongo_service: false
plugin_mongo_service_version: 9.0.16
# installation directory
plugin_mongo_service_install_dir: "{{base_dir}}/mongo-service_{{plugin_mongo_service_version|replace('.','_')}}"


mongo_plugin_service_environment_variable:

plugin_mongo_service_docker_project_name: "mongo_plugin_service_docker_version"

plugin_mongo_database_name: "edu-sharing"
plugin_mongo_database_user: "repository"
plugin_mongo_database_pass: "repository"
plugin_mongo_database_root_user: "root"
plugin_mongo_database_root_pass: "root"
plugin_mongo_database_replication_set_key: "repository"


mongo_plugin_environment_variable:
    - "REPOSITORY_MONGO_CONNECTION_STRING=mongodb://{{ plugin_mongo_database_user | default('repository', true) }}:{{ plugin_mongo_database_pass | default('repository', true) }}@repository-mongo:27017/{{ plugin_mongo_database_name | default('edu-sharing', true) }}"
    - "REPOSITORY_MONGO_DATABASE={{ plugin_mongo_database_name | default('edu-sharing', true) }}"
```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `cleanup.yml`: use to cleanup all the `*.amp|*.jar` files.
3. `download-and-install-docker-compose.yml`: use to download and install docker compose files for mongo-plugin.
4. `download-config-plugin.yml`: use to download and install the config plugin files, required for mongo-plugin.
5. `download-docker-plugin.yml`: use to download and install the docker plugin files, required for mongo-plugin.
6. `download-plugin-mongo-alfresco-amp.yml`: use to download and install the alfresco `amps` files.
7. `download-plugin-mongo-service-amp.yml`: use to download and install the edu-sharing `amps` files.


## Templates

The `template/` directory contains template files.

1. `.env.j2`: a `.env` template file, which ansible will replace it with correct variables
2. `3_plugin-mongo-override-common.yml.j2`: Use to override mongo service.
3. `deploy.sh.j2`: uShell script, used to start,restart,stop mongo-plugin

## Vars

The `vars/` directory contains all the variables, for each version of mongo-plugin, for each version we need some variables, and URL that ansible needs to
