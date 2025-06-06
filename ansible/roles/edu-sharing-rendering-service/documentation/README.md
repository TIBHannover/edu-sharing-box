# Ansible Role: edu-sharing-rendering-service

The `edu-sharing-rendering-service` role is used update the rendering service.

## Implementation

The `edu-sharing-rendering-service` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-rendering-service
      tags: 
        - edu-sharing-rendering-service

```

or we just want to run only the `edu-sharing-rendering-service` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-rendering-service"
```
This will skip other roles and run only the edu-sharing-rendering-service role

## Role Variables

The `edu-sharing-rendering-service` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
---
rendering_environment_variable:
  - key: SERVICES_RENDERING_SERVICE_HOST
    value: '{{edu_sharing_host}}'
  - key: SERVICES_RENDERING_SERVICE_PORT
    value: '{{edu_sharing_port | default("80",true)}}'
  - key:  SERVICES_RENDERING_SERVICE_PORT_HTTP
    value: '{{rendering_service_port_http| default("9100",true)}}'
  - key: SERVICES_RENDERING_SERVICE_PROT
    value: '{{rendering_service_prot| default("http",true)}}'
  - key: SERVICES_RENDERING_SERVICE_GDPR_ENABLED
    value: '{{rendering_service_enable_gdpr| default("false",true)}}'
  - key: SERVICES_RENDERING_SERVICE_GDPR_MODULES
    value: '{{rendering_service_gdpr_modules| default("",true)}}'
  - key: SERVICES_RENDERING_SERVICE_GDPR_URLS
    value: '{{rendering_service_gdpr_urls| default("",true)}}'
  - key: SERVICES_RENDERING_SERVICE_PLUGINS
    value: '{{rendering_service_plugins| default("",true)}}'
  - key: SERVICES_RENDERING_SERVICE_VIEWER_ENABLED
    value: '{{rendering_service_viewer_enabled| default("true",true)}}'
  - key: SERVICES_RENDERING_SERVICE_CACHE_CLEANER_SCHEDULE
    value: '{{ rendering_service_cache_cleaner_schedule | default("0 0 * * 0", true) | quote }}'
  - key: SERVICES_RENDERING_RENDERMOODLE_URL
    value: '{{rendering_service_rendering_module_url| default("",true)}}'
  - key: SERVICES_RENDERING_RENDERMOODLE_TOKEN
    value: '{{rendering_service_rendering_module_token| default("",true)}}'
  - key: SERVICES_RENDERING_RENDERMOODLE_CATEGORY_ID
    value: '{{rendering_service_rendering_module_category_id| default("1",true)}}'
  - key: SERVICES_RENDERING_AUDIO_FORMATS
    value: '{{rendering_service_audio_format| default("mp3",true)}}'
  - key: SERVICES_RENDERING_VIDEO_FORMATS
    value: '{{rendering_service_video_format| default("mp4,webm",true)}}'
  - key: SERVICES_RENDERING_VIDEO_RESOLUTIONS
    value: '{{rendering_service_video_resolutions| default("240,720,1080",true)}}'
  - key: SERVICES_RENDERING_VIDEO_DEFAULT_RESOLUTION
    value: '{{rendering_service_video_default_resolution| default("720",true)}}'

  # If we need to override the service name, then we can override it,
  # example:  in the edu-sharing-init/vars/versions/8.1.0.yml we add this variable with new value
  service_rendering_service: 'services-rendering-service'

```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `config-env.yml`: Used to update the .env file with rendering service variables
