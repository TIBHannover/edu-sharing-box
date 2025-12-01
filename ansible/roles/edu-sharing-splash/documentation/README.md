# Ansible Role: edu-sharing-splash

> By default edu-sharing-splash is not activated. To activate, set `enable_edu_sharing_splash: true`

The `edu-sharing-splash` role is responsible for setting up a screenshot service for edu-sharing. This role supports two different services:
- **Splash**: A lightweight browser rendering service
- **Playwright**: A modern browser automation service ([Source Code](https://gitlab.com/e.kacaj/playwright-splash))

## Implementation

The `edu-sharing-splash` role is included in the playbook [system.yml](../../../system.yml).
To activate the screenshot service, set `enable_edu_sharing_splash: true` in `all.yml` variables.

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-splash
      tags: 
        - edu-sharing-splash

```

To run only the `edu-sharing-splash` role:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-splash"
```
This will skip other roles and run only the edu-sharing-splash role.


## Role Variables

The `edu-sharing-splash` role allows you to customize variables according to your requirements. 

Here are the default variables:

```yaml
---
# Activate/deactivate screenshot service
enable_edu_sharing_splash: false

# Screenshot service type: 'splash' or 'playwright'
screenshot_service_type: 'splash'

edu_sharing_splash_location: '/edu-splash'
# URL of the screenshot service for http previews
edu_sharing_splash_url: '{{ edu_sharing_protocol | default("http") }}://{{edu_sharing_host}}{{edu_sharing_splash_location | default("/edu-splash",true)}}/render.png'

# External port for the screenshot service
edu_sharing_splash_port: 8050

# Splash configuration
splash_image: 'scrapinghub/splash'
splash_internal_port: 8050

# Playwright configuration
playwright_image: 'registry.gitlab.com/e.kacaj/playwright-splash:latest'
playwright_internal_port: 5050
```

### Choosing Between Splash and Playwright

Set the `screenshot_service_type` variable to choose your preferred service:

- **For Splash**: `screenshot_service_type: 'splash'`
- **For Playwright**: `screenshot_service_type: 'playwright'`

When you switch between services, the role automatically:
1. Removes the previously installed service container
2. Installs the newly selected service
3. Configures edu-sharing accordingly

### Playwright Source Code

The custom Playwright implementation used in this role is available at:
**https://gitlab.com/e.kacaj/playwright-splash**

## Tasks

The `tasks/` directory contains all the ansible tasks.

- `main.yml`: The main entry task for ansible.
- `install.yml`: Cleans up any existing screenshot service containers and installs the selected service.
- `install-splash.yml`: Installs and runs the Splash service.
- `install-playwright.yml`: Installs and runs the Playwright service.
- `register_apache.yml`: Registers the screenshot service with Apache for external access.
- `register_splash.yml`: Registers the screenshot service configuration in edu-sharing.
- `unregister.yml`: Rolls back the configuration if `enable_edu_sharing_splash` is false.

## Templates

The `template/` directory contains template files.

1. `edu_splash.conf.j2`: Apache configuration file for proxying the screenshot service.

## Examples

### Using Splash (default)
```yaml
enable_edu_sharing_splash: true
screenshot_service_type: 'splash'
edu_sharing_splash_port: 8050
```

### Using Playwright
```yaml
enable_edu_sharing_splash: true
screenshot_service_type: 'playwright'
edu_sharing_splash_port: 8050
```

### Custom Configuration
```yaml
enable_edu_sharing_splash: true
screenshot_service_type: 'playwright'
edu_sharing_splash_port: 9000
playwright_image: 'registry.gitlab.com/e.kacaj/playwright-splash:v1.2.3'
playwright_internal_port: 5050
```
