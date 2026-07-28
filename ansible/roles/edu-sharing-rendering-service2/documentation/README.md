# Ansible Role: edu-sharing-rendering-service2

The `edu-sharing-rendering-service2` role manages the new rendering service for edu-sharing, which was developed and rewritten by metaventsi company.

## Implementation

The `edu-sharing-rendering-service2` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
  - role: edu-sharing-rendering-service2
    tags: 
      - edu-sharing-rendering-service2

```

> `edu-sharing-rendering-service2` is not activated by default. To activate, set `enable_rendering_service_2: true` in your inventory variables.

To run only the `edu-sharing-rendering-service2` role:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-rendering-service2"
```

This will skip other roles and run only the edu-sharing-rendering-service2 role.

## Role Variables

The `edu-sharing-rendering-service2` role allows you to customize the following variables:

```yaml
---
# Version of rendering service 2 to install
rendering_service_2_version: 10.0.0

# Installation directory for rendering service 2
rendering_service_2_plugin_install_dir: "{{base_dir}}/rendering-service-2_{{rendering_service_2_version|replace('.','_')}}"

# Docker project name (must match edu-sharing's project name for backup compatibility)
rendering_service_2_docker_project_name: "{{edu_sharing_docker_project_name}}"

# Enable/disable the rendering service 2 instance
enable_rendering_service_2: false

# Keep both rendering services running in parallel
keep_both_rendering_services: false

# Custom deploy command (default uses docker)
rendering_service_2_deploy_command: 'sg docker -c "./deploy.sh start"'
```

## Tasks

The `tasks/` directory contains all the ansible tasks:

1. `main.yml`: The main entry point for the role
2. `cleanup.yml`: Cleans up rendering service 2 containers and configuration
3. `download-and-install-docker-compose.yml`: Downloads and installs required Docker Compose files
4. `register_apache_vhost.yml`: Registers Apache virtual host for rendering service 2
5. `unregister.yml`: Unregisters rendering service 1 when rendering service 2 is enabled (if `keep_both_rendering_services` is false)


### Parallel Services

By default, enabling rendering service 2 will disable rendering service 1. To run both services in parallel:

```yaml
enable_rendering_service_2: true
keep_both_rendering_services: true
```

## Files and Templates

### Templates Directory

Templates used by this role:

1. `.env.j2`: Environment configuration file for rendering service 2
2. `3_rendering2-override-common.yml.j2`: Docker Compose override configuration
3. `deploy.sh.j2`: Shell script for managing rendering service 2 startup/shutdown

## Handlers

- `cleanup rendering containers`: Cleans up rendering service containers after updates
- `cleanup rendering2 containers`: Cleans up rendering service 2 containers after updates

## Example Inventory Configuration

```yaml
# Enable rendering service 2
enable_rendering_service_2: true

# Optional: Keep both services running
keep_both_rendering_services: true

# Optional: Set a specific version
rendering_service_2_version: 10.0.0
```

## Domain Name Requirements

**Important:** The rendering service 2 requires a domain name to function properly, not an IP address.

### Why Domain Names are Required

The rendering service 2 uses domain-based routing and certificate handling which are incompatible with IP-only configurations. This is a technical requirement of how the service manages requests and security.

### Vagrant Hostname Configuration

This project uses the `vagrant-hostmanager` plugin to automatically manage hostnames on both your host machine and the guest VM. The Vagrantfile is configured with:

```ruby
config.hostmanager.enabled = true
config.hostmanager.manage_guest = true
config.hostmanager.manage_host = true

srv.vm.hostname = "twillo.local"
srv.hostmanager.aliases = %w(www.twillo.local edu-sharing.box)
```

For more detailed information about setting up custom hostnames with Vagrant and VirtualBox, refer to this blog post:

👉 [Custom Hostnames with Vagrant & VirtualBox](https://www.edmondkacaj.com/posts/custom-hostnames-vagrant-virtualbox)

### Configuration Steps

1. **Ensure vagrant-hostmanager is installed:**
   ```bash
   vagrant plugin install vagrant-hostmanager
   ```

2. **Configure your Vagrant hostname** in your Vagrantfile:
   ```ruby
   srv.vm.hostname = "twillo.local"
   ```

3. **Update the `edu_sharing_host` variable** in your inventory file (`ansible/group_vars/all.yml` or host-specific vars):
   
   Change from:
   ```yaml
   edu_sharing_host: 192.168.98.101
   ```
   
   To:
   ```yaml
   edu_sharing_host: twillo.local
   ```
   
   > **Note:** The hostname doesn't need to match the VM's hostname exactly. You can use any domain name (e.g., `edu-sharing.local`, `edusharing.dev`, etc.) as long as it's configured in your Vagrant setup and resolves properly.

4. **Apply the changes:**
   ```bash
   vagrant up
   # or if VM already running:
   ansible-playbook -v -i ansible/group_vars/all.yml ansible/system.yml --tags "edu-sharing-rendering-service2"
   ```

5. **Access the services:**
   - edu-sharing main application: `http://twillo.local/edu-sharing`
   - rendering service 2: `http://twillo.local` (as configured)

### Hostname Aliases

You can also define additional hostname aliases in your Vagrantfile:

```ruby
srv.hostmanager.aliases = %w(www.twillo.local edu-sharing.box other-alias.local)
```

All aliases will be automatically added to your host machine's hosts file when you run `vagrant up`.

### Troubleshooting Domain Configuration

- **Hostname not resolving:** Make sure `vagrant-hostmanager` is installed and that `config.hostmanager.manage_host = true`
- **Changes not applied:** Run `vagrant hostmanager` to manually update hostnames
- **Old IP still in use:** Clear browser cache or use incognito mode to test with new domain
- **Apache vhost not working:** Verify Apache is recognizing the new ServerName directive in its configuration
