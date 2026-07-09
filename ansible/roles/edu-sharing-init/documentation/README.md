# Ansible Role: edu-sharing-init

The edu-sharing-init role automates the installation and initialization of the edu-sharing platform in a Docker environment. It also facilitates the installation of Alfresco plugins (_alfviral_,_es-update-oersi_) and sets up the basic configuration necessary to start using edu-sharing.

## Implementation

__edu-sharing-init__ role is included in to the playbook see: [system.yml](../../../system.yml).


```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-init
      tags: 
        - edu-sharing-init

```

or we just want to run only the `edu-sharing-init` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-init"
```
This will skip other roles and run only the edu-sharing-init role

## Role Variables

__edu-sharing-init__ role allows you to customize certain variables according to your requirements. Here are the default variables:


```yaml

# Used ony if the tomcat is is still there, if we changed the default one then we can override
tomcat_stop_command: "{{base_dir}}/bin/tomcat.sh stop 2> /dev/null || true"

# Force docker container to use the specific timezone
edu_sharing_docker_timezone: '{{timezone | default("Europe/Berlin",true)}}'

# Basic configuration used for starting and running edu-sharing
edu_sharing_environment_variable:
  - key: COMPOSE_PROJECT_NAME
    value: '{{edu_sharing_docker_project_name}}'
  - key: REPOSITORY_DATABASE_NAME
    value: '{{alfresco_db.name}}'
  - key: REPOSITORY_DATABASE_USER
    value: '{{alfresco_db.user}}'
  - key: REPOSITORY_DATABASE_PASS
    value: '{{alfresco_db.password}}'
  - key: COMMON_BIND_HOST
    value: '{{common_bind_host | default("127.0.0.1",true)}}'
  - key: REPOSITORY_SERVICE_GUEST_USER
    value: '{{guest_user_name | default("esguest",true)}}'
  - key: REPOSITORY_SERVICE_GUEST_PASS
    value: '{{guest_user_password | default("esguest",true)}}'
  - key: REPOSITORY_SERVICE_ADMIN_PASS
    value: '{{alf_password}}'
  - key: SERVICES_RENDERING_DATABASE_NAME
    value: '{{esrender_db.name}}'
  - key: SERVICES_RENDERING_DATABASE_USER
    value: '{{esrender_db.user}}'
  - key: SERVICES_RENDERING_DATABASE_PASS
    value: '{{esrender_db.password}}'
  
  # MongoDB configuration for edu-sharing services
  - key: MONGO_DATABASES_ROOT_USER
    value: '{{mongo_databases.root_user | default("root",true)}}'
  - key: MONGO_DATABASES_ROOT_PASS
    value: '{{mongo_databases.root_pass | default("root",true)}}'
  - key: MONGO_DATABASES_REPLICATION_SET_KEY
    value: '{{mongo_databases.replication_set_key | default("edusharing",true)}}'
  
  # Rendering2 service database configuration
  - key: RENDERING2_SERVICE_DATABASE_NAME
    value: '{{esrender2_db.name | default("rendering",true)}}'
  - key: RENDERING2_SERVICE_DATABASE_USER
    value: '{{esrender2_db.user | default("rendering",true)}}'
  - key: RENDERING2_SERVICE_DATABASES_PASS
    value: '{{esrender2_db.password | default("rendering",true)}}'
  
  # LUMI service database configuration
  - key: RENDERING2_LUMI_DATABASE_NAME
    value: '{{esrender2_lumi_db.name | default("lumi",true)}}'
  - key: RENDERING2_LUMI_DATABASE_USER
    value: '{{esrender2_lumi_db.user | default("lumi",true)}}'
  - key: RENDERING2_LUMI_DATABASE_PASS
    value: '{{esrender2_lumi_db.password | default("lumi",true)}}'

    # Notification service database configuration
  - key: NOTIFICATION_SERVICE_DATABASE_NAME
    value: '{{notification_service.db_name | default("notification",true)}}'
  - key: NOTIFICATION_SERVICE_DATABASE_USER
    value: '{{notification_service.db_user | default("notification",true)}}'
  - key: NOTIFICATION_SERVICE_DATABASE_PASS
    value: '{{notification_service.db_pass | default("notification",true)}}'

   # Repository service database configuration
  - key: REPOSITORY_MONGO_DATABASE
    value: '{{plugin_mongo_database_name | default("repository",true)}}'
  - key: REPOSITORY_MONGO_USER
    value: '{{plugin_mongo_database_user | default("repository",true)}}'
  - key: REPOSITORY_MONGO_PASS
    value: '{{plugin_mongo_database_pass | default("repository",true)}}'
```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `model`: This task is used to override existing images and build a custom container.
3. `config-env`: This task is used to copy and override the `.env` file.
4. `clean-edu-sharing-volumes`: This task deletes all volumes except the database and alfresco content data whenever the version changes.
5. `alfresco-model`: This task is used to override the alfresco extension models.
6. `set_edu_docker_inst_dir`: Used to refactor the folder name according to docker convention, for example `edu-sharing-9.0.1-RC1` with become `edu-sharing-9_0_1_rc1`
7. `extract_image_from_repository_service`: used to get the image of the `repository-service`, since it is different from RC and release version 


## Templates

 The `templates/` directory edu-sharing override docker files.

 It contains: 

 1. `3_repository-service-volume-override-common.yml` Used to override the volumes,and add the custom image, work only for version 7.
 2. `docker-compose.override.yml.j2` Used to override the volumes,and add the custom image, work only for version 8 and above.
 3. `Dockerfile_repository-service.j2` Used to override the Image and create a custom image



 ## Vars

 The `vars/` directory contains the edu-sharing versions, and the necessary commands.

 in order to add another version of edu-sharing we create a file with that version, example: if we want to have version `8.5.0` then we create a file in `vars/versions/8.5.0.yml`

 ```yaml

  edu_sharing_archive_url: https://artifacts.edu-sharing.com/repository/maven-remote/org/edu_sharing/edu_sharing-projects-community-deploy-docker-compose/8.1.0/edu_sharing-projects-community-deploy-docker-compose-8.1.0-bin.zip

  # In newer versions Edu-sharing may change the deploy commands, if so we can change them here
  # {service} is an variable tha ansible will replace, based on what service we want to execute the action
  edu_sharing_deploy_command: 'sg docker -c "./utils.sh start {service}"'
  edu_sharing_restart_command: 'sg docker -c "./utils.sh restart {service}"'
  # remove docker images from server
  edu_sharing_undeploy_command: 'sg docker -c "./utils.sh stop {service}"'
  edu_sharing_remove_containers_command: |
      yes | sg docker -c "./utils.sh remove {service}"

  # this will remove images,containers and volumes, so be carefully when we use it.
  edu_sharing_purge_all_command: |
      yes | sg docker -c "./utils.sh purge {service}"

  # Edu-sharing backup command
  edu_sharing_backup_command: 'sg docker -c "./utils.sh backup {options}"'
  # Edu-sharing restore command
  edu_sharing_restore_command: 'sg docker -c "./utils.sh restore {options}"'

 ```

