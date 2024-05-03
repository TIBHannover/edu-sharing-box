# Backup einrichten

Backup Ansible-Variablen im Inventory-File setzen (siehe [ansible/group_vars/all.yml](ansible/group_vars/all.yml))

* **backup_process_state**: `present` - Activate/Deactivate backup script
* **backup_schedule_hour**: \<HOUR\> - hours the backup script will run
* **backup_path**: '\<BACKUP-PATH\>' - path where the backup will be saved

### Installation

In order to start an automatic backup activate the script `backup_process_state: present`

and the ansible will do the job.

> INFO !! the backup process will go through an optimization process and use the script provided by edu-sharing ite self

