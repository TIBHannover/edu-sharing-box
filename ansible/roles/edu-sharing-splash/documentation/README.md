# Ansible Role: edu-sharing-splash

> By default edu-sharing-splash is not activated, in order to activate you need to make `enable_edu_sharing_splash: true`


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
---
# Activate/deactivate Splash
enable_edu_sharing_splash: true
edu_sharing_splash_location: '/edu-splash'
# "http://{{ host }}:8050/render.png" # URL of the splash-service for http previews
edu_sharing_splash_url: '{{ edu_sharing_protocol | default("http") }}://{{edu_sharing_host}}{{edu_sharing_splash_location | default("/edu-splash",true)}}/render.png'

edu_sharing_splash_port: 8050

```

## Tasks

The `tasks/` directory contains all the ansible tasks.

- `main.yml`: The main task or entry task for ansible.
- `install.yml`: Install and run splash.
- `register_apache`: Register the edu-sharing-splash, so we can access from outside.
- `register_splash`: Register splash into edu-sharing.
- `unregister`: Rollback the configuration, if the `enable_edu_connector` is false or not defined.

## Templates

The `template/` directory contains template files.

1. `edu_splash.conf.j2`: apache configuration file.