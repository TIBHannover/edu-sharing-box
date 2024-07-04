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

# Edu-sharing-plugin-oersi-update AMP

# Edu-sharing-plugin-oersi-update see: gitlab.com/TIBHannover/oer/edu-sharing-plugin-oersi-update
es_update_oersi_version: 1.0.1
es_update_oersi_amp_filename: "es-update-oersi-{{es_update_oersi_version}}.amp"
# oersi update endpoint 
es_update_oersi_url: 'https://oersi.org/resources/api-internal/import-scripts/python/update-record'
es_update_oersi_configuration:
  - key: oersi.url
    value: "{{es_update_oersi_url | default('',true)}}"
  - key: edu_sharing.baseUrl
    value: "{{edu_sharing_url | default('',true)}}"

# Alfviral AMP

# antivirus alfviral see: https://github.com/TIBHannover/alfviral
antivirus_alfviral_version: 1.4.0-TIB.2
antivirus_alfviral_amp_filename: 'alfviral-{{ antivirus_alfviral_version }}.amp'

alfviral_antivirus_configuration:
  - key: alfviral.mode
    value: "INSTREAM"
  - key: alfviral.instream.timeout
    value: "{{antivirus_alfviral_timeout | default(10000,true)}}"
  - key: alfviral.instream.host
    value: "{{clamav_proxy}}"
  - key: alfviral.instream.port
    value: "{{antivirus_alfviral_port | default(3310,true)}}"
  - key: alfviral.on_update.delete
    value: "{{ antivirus_alfviral_on_update_delete | default('true',true) }}"
  - key: alfviral.notify.user
    value: "{{ antivirus_alfviral_notify_user | default('true',true)}}"
  - key: alfviral.notify.admin
    value: "{{ antivirus_alfviral_notify_admin | default('true',true)}}"
  - key: alfviral.notify.asynchronously
    value: "{{ antivirus_alfviral_notify_asynchronously | default('false',true) }}"
  - key: alfviral.notify.user.template
    value: "{{ antivirus_alfviral_user_template | default('notify_user_en.html.ftl',true) }}"
  - key: alfviral.notify.admin.template
    value: "{{ antivirus_alfviral_admin_template | default('notify_admin_en.html.ftl',true) }}"
  - key: alfviral.file.exceptions
    value: ""


# Mail configuration
mail_configuration:
  - key: mail.host
    value: "{{ edu_mail_smtp_server | default('') }}"
  - key: mail.port
    value: '{{ edu_mail_smtp_port | default("25") }}'
  - key: mail.username
    value: '{{ edu_mail_smtp_username | default("") }}'
  - key: mail.password
    value: '{{ edu_mail_smtp_passwd | default("") }}'
  - key: mail.encoding
    value: '{{ edu_mail_smtp_encoding | default("UTF-8",true) }}'
  - key: mail.from.default
    value: '{{ edu_mail_smtp_from | default("pleasechange@nodomain.com") }}'
  - key: mail.smtp.auth
    value: '{{ edu_mail_smtp_auth | default("false") }}'
```

## files 

This directory houses AMP (Alfresco Module Package) files, essential for installation within the Alfresco software. Currently, we don't offer an automated download and extraction process for Alfresco. Hence, it's necessary to manually download the files from their respective repositories and extract them into the `file/` directory.


 1. [Alfviral](https://github.com/TIBHannover/alfviral) This antivirus plugin is utilized as an Alfresco plugin. 
 2. [Edu-sharing-plugin-oersi-update](gitlab.com/TIBHannover/oer/edu-sharing-plugin-oersi-update) Another Alfresco plugin used for sending notifications to oersi.org when public materials are changed or deleted.

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `model`: This task is used to override existing images and build a custom container.
3. `config-env`: This task is used to copy and override the `.env` file.
4. `configure_alfresco_properties`: This task is used to override the alfresco-global.properties.
   - `remove_alviral_and_mail_from_alfresco_properties`: Used to remove the configuration for alfviral and mail.
   - `add_alviral_to_alfresco_properties`: Used to add the alfviral configuration.
   - `add_mail_config_to_alfresco_properties`: Used to configure the mail.
   - `add_es_update_oersi_to_alfresco_properties`: Used to add the es-update-oersi.
5. `clean-edu-sharing-volumes`: This task deletes all volumes except the database and alfresco content data whenever the version changes.
6. `alfresco-model`: This task is used to override the alfresco extension models.
7. `alfresco_amp_modules`: This task adds the path of AMP files.
   - `alfviral`: Copies the alfviral AMP to the server.
   - `es_update_oersi`: Copies the es-update-oersi AMP to the server.


## Templates

 The `templates/` directory edu-sharing override docker files.

 It contains: 

 1. `3_repository-service-volume-override-common.yml` Used to override the volumes,and add the custom image, work only for version 7.
 2. `docker-compose.override.yml` Used to override the volumes,and add the custom image, work only for version 8 and above.
 3. `Dockerfile_repository-service` Used to override the Image and create a custom image



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

