# Ansible Role: edu-sharing-migration

The `edu-sharing-migration` role is used to migrate data (Database and Alfresco content data) from version 6 and below to version 7 and above.

This role is one time role, meaning that after the successful migration, it will not be executed anymore

## Implementation

The `edu-sharing-migration` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-migration
      tags: 
        - edu-sharing-migration

```

or we just want to run only the `edu-sharing-migration` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-migration"
```
This will skip other roles and run only the edu-sharing-migration role



## Role Variables

The `edu-sharing-migration` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
# It will work only if the database for edu-sharing version 6 and below used to use postgresql database
alfresco_db_type: postgresql

# alfresco installation directory
alf_name: alfresco-community-distribution-201707
alf_inst_dir: "{{base_dir}}"
alf_home: "{{alf_inst_dir}}/{{alf_name}}"


```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `migrate-edu-sharing.yml`: This task is used to check and prepare the migration. It will also delete all the volumes, as we need to remove everything and start with the migration.
3. `migrate-alfresco-data.yml`: This task is used to make a database backup and copy the alfresco content to the docker volume.


