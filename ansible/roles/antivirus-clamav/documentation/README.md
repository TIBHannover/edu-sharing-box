# Ansible Role: antivirus-clamav

The `antivirus-clamav` role is used to install antivirus clamAv. 

## Implementation

The `antivirus-clamav` role is included in the playbook [system.yml](../../../system.yml).
In order to activate the restore script you need to make true the `install_antivirus` in `all.yml` variables.

```yaml
- hosts: antivirus
  roles:
    - role: antivirus-clamav
      tags: 
        - antivirus-clamav

```

or we just want to run only the `antivirus-clamav` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "antivirus-clamav"
```
This will skip other roles and run only the antivirus-clamav role


## Role Variables

The `antivirus-clamav` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml

clamav_docker_version: stable

clamav_docker_install_dir: "{{base_dir}}/clamav_{{clamav_docker_version|replace('.','_')}}"

clamav_docker_internal_port: 3310
clamav_milter_docker_internal_port: 7357
# docker composer name
clamav_docker_docker_project_name: "clamav_docker_antivirus"

clamav_docker_no_freshclamd: "false"
clamav_docker_no_milterd: "true"
clamav_docker_no_clamd: "false"
clamav_docker_startup_timeout: 1800
clamav_docker_freshclamd_checks: 1


# Command to run edu-connector in docker
clamav_docker_run_command: 'sg docker -c "docker compose -f docker-compose.yml up -d"'

```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: Entry point .
2. `clamav`: Install and run clamav in docker.

## Templates

`templates` folder contains the `docker-compose.yml` files
