# Ansible Role: edu-sharing-splash

The `edu-sharing-splash` role is used to install the splash. [Splash](https://splash.readthedocs.io/en/stable/index.html) is a javascript rendering service, used to create  screenshots of html pages.

## Implementation

The `edu-sharing-splash` role is included in the playbook [system.yml](../../../system.yml).
In order to activate the restore script you need to make true the `install_splash` in `all.yml` variables.

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-splash
      tags: 
        - edu-sharing-splash

```

or we just want to run only the `edu-sharing-splash` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-splash"
```
This will skip other roles and run only the edu-sharing-splash role


## Role Variables

The `edu-sharing-splash` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
# Activate/deactivate Splash
install_splash: false


splash_port: 8050

```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: run splash in docker.
