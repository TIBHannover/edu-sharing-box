# Ansible Role: edu-sharing-connector

> By default edu-sharing-connector is not activated, in order to activate you need to make `enable_edu_connector: true`

The `edu-sharing-connector` role is used activate/deactivate edu-sharing-connector system for edu-sharing

## Implementation

The `edu-sharing-connector` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
  - role: edu-sharing-connector
    tags: 
      - edu-sharing-connector

```
or we just want to run only the `edu-sharing-connector` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-connector"
```
This will skip other roles and run only the edu-sharing-connector role

## Role Variables

The `edu-sharing-connector` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml

# Activate/Deactivate edu-sharing-connector
enable_edu_connector: false
# Edu-connector Version (Docker)
edu_connector_version: 9.0.0

edu_connector_internal_port: 9200
# docker composer name
edu_connector_docker_project_name: "edu_connector_docker_version"

# installation directory
edu_connector_install_dir: "{{base_dir}}/edu-connector_{{edu_connector_version|replace('.','_')}}"

# database configuration
edu_connector:
  db_name: 'connector'
  db_user: 'connector'
  db_password: 'connector'


# Enable modules for edu-sharing connector 
# example:
#     - id: 'TINYMCE'       # Required
#       icon: 'edit'        # optional default will be edit
#       showNew: true       # optional default will be true
#       onlyDesktop: true   # optional default will be true
#       hasViewMode: true   # optional default will be true
#       filetypes:          # Required
#         - {mimetype: "text/html",filetype: "html",createable: true,editable: true,editorType: "tinymce"}
# TINYMCE is by default
edu_connector_enable_modules:
        - id: 'H5P'
          filetypes:
            - {mimetype: "application/zip",filetype: "h5p", ccressourcetype: "h5p", createable: true,editable: true}  
```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `download.yml`: Download and extract the jar file.
3. `install.yml`: Do installation and start the edu-sharing-connector.
4. `register_apache.yml`: Register the edu-sharing-connector, so we can access from outside .
5. `unregister.yml`: Rollback the configuration, if the `enable_edu_connector` is false or not defined.
6. `register_connectors.yml`: Register connectors into edu-sharing.


## Templates

The `template/` directory contains template files.

1. `.env.j2`: a `.env` template file, which ansible will replace it with correct variables
2. `3_connector-override-common.yml.j2`: Override docker services.
3. `deploy.sh.j2`: Shell script, used to start,restart,stop notification service
4. `edu_connector.conf.j2`: apache configuration file.

## Vars

The `vars/` directory contains all the variables, for each version of notification-service, for each version we need some variables, and URL that ansible needs to
