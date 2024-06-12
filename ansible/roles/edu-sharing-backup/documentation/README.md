# Ansible Role: edu-sharing-backup

The `edu-sharing-backup` role is used to make backups for edu-sharing.

## Implementation

In order to activate the backup process, you need to activate it in the [all.yml](../../../group_vars/all.yml) by changing the `backup_process_state: present`

```yml
# enable / disable the edu-sharing backup process: present|absent
backup_process_state: absent

```

The `edu-sharing-backup` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-backup
      tags: 
        - edu-sharing-backup

```



or we just want to run only the `edu-sharing-backup` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-backup"
```
This will skip other roles and run only the edu-sharing-backup role

## Role Variables

The `edu-sharing-backup` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
---
# It can have more than one Option
# Options:
#   --all              Backup repository, elastic search index and apache solr index
#   --repo             Backup repository including binaries and databases
#   --repodb           Backups only the repository databases
#   --elastic          Backup elastic search index
#   --solr             Backup apache solr index
#   --compressed       Creates compressed backups
#   --hot-backup       Create a backup without stopping the systems
#                      This can lead to missing data and corrupted index in terms of the overall system
#                      Backups of each component are therefore still valid.

backup_script_option: "--repo --compressed"

backup_path: '{{ base_dir }}/backup'
backup_bin: '{{ script_dir }}'

# Run the backup script as soon as the script is installed in server
run_backup_script_instantly: false # true => it will run the script instantly

# Removes older backups but keeps n numbers
backup_keep_last_nr_directories: 1

# By default it will run every Sunday at midnight
backup_cron_schedule:
  minute: "0"
  hour: "0"
  weekday: "7"

```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `backup.yml`: tasks that activate the backup script and run it.

## Templates

The `templates/` directory contains the shell script used execute the backup script.

> INFO! the backup script work only for edu-sharing version >=8.0.0