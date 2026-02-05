# Ansible Role: edu-sharing-customization

The `edu-sharing-customization` role is used to customize the edu-sharing platform. This role focuses on customizing and updating only the edu-sharing service without affecting other services.

## Implementation

The `edu-sharing-customization` role is included in the playbook. See: [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-customization
      tags: 
        - edu-sharing-customization
```

To run only the `edu-sharing-customization` role, use the following command:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-customization"
```

This will skip other roles and run only the `edu-sharing-customization` role.

## Role Variables

The `edu-sharing-customization` role allows you to customize certain variables according to your requirements. Below are the default variables:

```yaml
---
---

# (internal) cleanup / set values in client.config.xml
# format:
#   xpath   - xpath where to set the value
#   value   - xml value
#   cleanup - xpath. if set, remove from client.config.xml before set values
edu_client_config_xml_standard_entries:
  - xpath: '/config/values/imprintUrl'
    value: '{{ edu_imprinturl | default("") }}'
  - xpath: '/config/values/privacyInformationUrl'
    value: '{{ edu_privacyInformationUrl | default("") }}'
  - xpath: '/config/values/register/local'
    value: '{{ edu_register_local }}'
  - xpath: '/config/values/register/recoverUrl'
    value: '{{ edu_recover_url }}'
    cleanup: '/config/values/register/recoverUrl'
  - xpath: '/config/values/banner/url'
    value: '{{ edu_banner_url | default("") }}'
    cleanup: '/config/values/banner'
  - xpath: '/config/values/banner/href'
    value: '{{ edu_banner_href | default("") }}'
    cleanup: '/config/values/banner'
  - cleanup: '/config/values/allowedLicenses'
  - cleanup: '/config/values/loginUrl'
  - cleanup: '/config/values/loginAllowLocal'
  - cleanup: '/config/values/loginProvidersUrl'
  - cleanup: '/config/values/loginProviderTargetUrl'
  - cleanup: '/config/values/logout'
  - xpath: '/config/values/workspaceViewType'
    value: '{{ "1" if (edu_workspace_viewType | default("list")) == "tile" else "0" }}'
    cleanup: '/config/values/workspaceViewType'
  - xpath: '/config/values/upload/postDialog'
    value: '{{ edu_upload_post_dialog }}'
  - xpath: '/config/values/publish/licenseMandatory'
    value: '{{ edu_license_mandatory | default(false) }}'
    cleanup: '/config/values/publish/licenseMandatory'
  - xpath: '/config/values/publish/authorMandatory'
    value: '{{ edu_author_mandatory | default(false) }}'
    cleanup: '/config/values/publish/authorMandatory'

# edu-sharing configuration type (edu_version < 5.1: 'edu-sharing.properties' and edu_version >= 5.1: 'edu-sharing.conf'
edu_config_file: 'edu-sharing.conf'

# trusted client configuration for oauthTokenService
edu_oauth_trusted_clients:
  - client: "eduApp"
    password: "secret"

edu_sharing_customization_environment_variable:
  - key: REPOSITORY_SERVICE_PORT
    value: '{{edu_sharing_port | default("80",true)}}'
  - key: REPOSITORY_SERVICE_HOST
    value: '{{edu_sharing_host}}'
  - key: REPOSITORY_SERVICE_MAIL_SERVER_SMTP_PORT
    value: '{{edu_mail_smtp_port if (edu_mail_smtp_server is not none) and (edu_mail_smtp_server is defined) else ""}}'
  - key: REPOSITORY_SERVICE_MAIL_FROM
    value: '{{edu_mail_smtp_from if (edu_mail_smtp_server is not none) and (edu_mail_smtp_server is defined) else ""}}'
  - key: REPOSITORY_SERVICE_MAIL_REPORT_RECEIVER
    value: '{{edu_mail_report_receiver if (edu_mail_smtp_server is not none) and (edu_mail_smtp_server is defined) else ""}}'
  - key: REPOSITORY_SERVICE_MAIL_SERVER_SMTP_USERNAME
    value: '{{edu_mail_smtp_username if (edu_mail_smtp_server is not none) and (edu_mail_smtp_server is defined) else ""}}'
  - key: REPOSITORY_SERVICE_MAIL_SERVER_SMTP_PASSWORD
    value: '{{edu_mail_smtp_passwd if (edu_mail_smtp_server is not none) and (edu_mail_smtp_server is defined) else ""}}'
  - key: REPOSITORY_SERVICE_MAIL_SERVER_SMTP_AUTHTYPE
    value: '{{edu_mail_authtype if (edu_mail_smtp_server is not none) and (edu_mail_smtp_server is defined) else ""}}'
  - key: REPOSITORY_SERVICE_MAIL_SERVER_SMTP_HOST
    value: '{{edu_mail_smtp_server | default("",true)}}'
  - key: REPOSITORY_SERVICE_HOME_APPID
    value: '{{edu_repo_id | default("local",true)}}'

# If we need to override the service name, then we can override it,
# example:  in the edu-sharing-init/vars/versions/8.1.0.yml we add this variable with new value
service_repository_service: 'repository-service'

# DOI service configuration for repository integration with DataCite.
# All fields are required except 'owner'.
edu_doi_configuration:
  enabled: false                # (required) Enable or disable the DOI service.
  repoUrl: '{{edu_sharing_url}}'  # (required) Base URL for repository node entries.
  baseUrl: 'https://api.test.datacite.org'       # (required) DataCite API endpoint (test or production).
  prefix: ''           # (required) DOI prefix assigned by DataCite.
  accountId: ''     # (required) DataCite API account ID.
  password: '' # (required) DataCite API password.

# DOI publishing configuration for copy-based publishing of nodes.
# All fields are required except 'owner'.
edu_doi_publishing_configuration:
  node: ''                     # (required) Node ID where published DOIs will be stored.
  node_pattern: 'yyyy/MM/dd'   # (required) Pattern for organizing published nodes.
  owner: ''                    # (optional) Owner for published DOIs; defaults to node owner if not set.

# Angular UI customization
# Configure via edu_angular_configs in inventory - only specified headers will be written.
# Supports both string values and nested objects for complex configurations.
# 
# Simple example:
#  edu_angular_configs:
#    headers:
#      X-Frame-Options: "DENY"
#      X-XSS-Protection: "1"
#
# Advanced example with nested CSP:
#  edu_angular_configs:
#    headers:
#      X-Frame-Options: "DENY" 
#      Content-Security-Policy:
#        default-src: "* data: blob: 'self' gap://ready"
#        connect-src: "* data:"
#        script-src: "* 'unsafe-inline' 'unsafe-eval' https://app-registry.edu-sharing.com"
#        frame-src: "*"
#    robots:
#      - "User-agent: *"
#      - "Disallow: /admin"

# Guest user configuration
# Allows anonymous users to access the repository with predefined permissions.
# When enabled, creates a guest user account with specified username and group memberships.
# Requires repository restart to take effect.
#
# Configuration variables:
#   enable_guest_user: boolean to enable/disable guest access (default: false)
#   guest_user_name: username for guest user (default: "esguest")
#   guest_user_groups: list of groups for guest user (default: [])
#
# Example:
#  enable_guest_user: true
#  guest_user_name: "esguest"
#  guest_user_groups:
#    - "GROUP_EVERYONE"
#    - "GROUP_GUEST"

# Custom jobs configuration (Quartz)
# Adds custom jobs to edu-sharing.override.conf using "jobs.entries += { ... }".
# If edu_system_jobs is undefined or empty, the jobs block will be removed.
#
# Fields:
#   job_class  - (required) Fully qualified Java class name for the job
#   name       - (optional) Job display name. If omitted, derived from job_class
#   trigger    - (optional) Quartz trigger. Defaults to "Immediate"
#   parameters - (optional) Job-specific parameters (string values)
#   <any_key>  - (optional) Additional key-value pairs are written to the job
#
# Quartz Cron format: Cron[second minute hour day-of-month month day-of-week]
# Day-of-week: 0 or 7 = Sunday, 1 = Monday, ..., 6 = Saturday
#
# Example (with JSON parameter value):
# edu_system_jobs:
#   - job_class: "org.edu_sharing.repository.server.jobs.quartz.FixElasticSearchDeletedNodes"
#     name: "Weekly ES Cleanup"
#     trigger: "Cron[0 0 4 ? * 0]"
#     parameters:
#       cleanupChildren: "true"
#       execute: "false"
#       query: '{"term":{"type":"ccm:io"}}'
#
# Example (extra keys):
# edu_system_jobs:
#   - job_class: "org.edu_sharing.repository.server.jobs.quartz.LicenseManagerJob"
#     trigger: "Cron[0 0 * * * ?]"
#     status: "active"
#     priority: "10"
```

## Tasks

The `tasks/` directory contains all the ansible tasks.

### `config-cluster`

This directory contains all the customization tasks for the `repository-service-volume-config-cluster` volume.

1. **`add_repository_statistics.yml`**: Adds repository statistics configuration.
2. **`add_remove_repository_doi_service.yml`**: Configures the DOI (Digital Object Identifier) service for the repository.
3. **`youtube.yml`**: Configures YouTube integration for the repository.
4. **`pixabay.yml`**: Configures Pixabay integration for the repository.
5. **`lms.yml`**: Configures LMS (Learning Management System) integration for the repository.
6. **`add_remove_angular_headers.yml`**: Manages Angular security headers and robots in `edu-sharing.override.conf` using `edu_angular_configs`. Writes or removes dedicated blocks via Ansible blockinfile.
7. **`add_remove_guest_configuration.yml`**: Manages guest user configuration in `edu-sharing.override.conf`. Enables anonymous access with configurable username and group memberships using `enable_guest_user`, `guest_user_name`, and `guest_user_groups` variables.
8. **`add_remove_jobs_configuration.yml`**: Manages Quartz job entries in `edu-sharing.override.conf` using `edu_system_jobs`. Adds or removes the jobs block depending on whether the variable is defined and non-empty.

### `config-edu-sharing`

This directory contains all the customization tasks for the `repository-service-volume-config-edu-sharing` volume.

1. **`add_custom_metadata.yml`**: Adds custom metadata configurations to the edu-sharing repository.
2. **`configure_authentication.yml`**: Configures authentication settings for the repository.
3. **`update_permissions.yml`**: Updates permissions for specific repository users or groups.

### `config-node`

This directory contains all the customization tasks for the `repository-service-volume-config-node` volume.

1. **`node_configuration.yml`**: Configures node-specific settings for the repository.
2. **`node_metadata.yml`**: Adds or updates metadata for repository nodes.
3. **`node_permissions.yml`**: Configures permissions for repository nodes.

### Other Tasks

1. **`adjust_env_variables.yml`**: This task is used to override the `.env` file.
2. **`jobs.yml`**: This task executes jobs.
3. **`shiboleth_before.yml`**: This task makes some customizations required before activating Shibboleth.

## Templates

The `templates/` directory contains files that will be injected into the edu-sharing docker.

It contains:

1. **`lms.properties.xml.j2`**: Used to add and activate LMS platforms.
2. **`oersi.properties.xml.j2`**: Used to add and activate OERSI platforms.
3. **`pixabay.properties.xml.j2`**: Used to add and activate Pixabay platforms.
4. **`youtube.properties.xml.j2`**: Used to add and activate YouTube platforms.

## Files

The `files/` directory contains static files used by the role.

## Defaults

The `defaults/` directory contains default variables for the role. These variables can be overridden in the playbook or inventory.
