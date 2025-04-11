# Ansible Role: edu-sharing-restore

The `edu-sharing-restore` role is used restore data from backups edu-sharing, it works only if we have done backup before

## Implementation

The `edu-sharing-restore` role is included in the playbook [system.yml](../../../system.yml).
In order to activate the restore script you need to make true the `edu_sharing_restore_from_backup` in `all.yml` variables.

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-restore
      tags: 
        - edu-sharing-restore

```

or we just want to run only the `edu-sharing-restore` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-restore"
```
This will skip other roles and run only the edu-sharing-restore role


## Role Variables

The `edu-sharing-restore` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
backup_path: '{{ base_dir }}/backup'


# backup_folder is used if you want to specify the path, or we have more than one backup.
# example: 
#   backup_folder: "{{backup_path}}/21-05-2024_14_41_05"
# by default the script will search and restore data from the latest backup folder
# backup_folder:
```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `get_backup.yml`: This task is used to retrieve the latest backup folder, if the `backup_folder` is not defined.
3. `restore.yml`: This task is used to restore the data.
