# Ansible Role: edu-sharing-shibboleth

> By default, `edu-sharing-shibboleth` is not activated. To activate it, set `edu_configure_shibboleth: true` in the Ansible variables.

The `edu-sharing-shibboleth` role is responsible for configuring Shibboleth authentication in an edu-sharing environment. It ensures that the necessary configurations are applied, including modifying XML files, updating environment variables, and managing authentication settings.

## Implementation

The `edu-sharing-shibboleth` role is included in the playbook [system.yml](../../../system.yml).  
To enable Shibboleth authentication, set `edu_configure_shibboleth: true` in `all.yml`.

```yml
- hosts: edusharing
  roles:
    - role: edu-sharing-shibboleth
      tags:
        - edu-sharing-shibboleth
```

To run only the `edu-sharing-shibboleth` role, execute:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-shibboleth"
```

This will skip other roles and execute only the `edu-sharing-shibboleth` role.

## Role Variables

The `edu-sharing-shibboleth` role allows customization of certain variables. Below are the default values:

```yml
  ---
  edu_configure_shibboleth: "{{ install_shibboleth }}" # Activate shibboleth authentication in edu-sharing true|false (if set to false and 'install_shibboleth' to true, you can install shibboleth without activation in edu-sharing)
  # allow additional local edu-sharing login, otherwise login redirects directly to 'edu_login_shib_url' 'true'|'false'
  edu_login_allow_local: "true"
  # the login url that should be used for shibboleth login
  edu_login_shib_url: "{{ edu_sharing_url }}/shibboleth"
  # configuration of the next two variables allows to login at the IdP directly or at the local edu-Sharing
  # example: https://smart.vhb.org/edu-sharing/components/login
  # these variables require service endpoints that provide a list of all Shibb-IdPs
  # NOTE: this is not implemented here!
  #edu_login_providers_url: 'test'
  #edu_login_provider_target_url: 'test'

  edu_sso_context_path: edu-sharing-sso-context.xml # absolut or relative path to edu-sharing-sso-context.xml

  edu_sharing_shibboleth_env_variable:
    - key: REPOSITORY_SERVICE_AUTH
      value: '{{ "shibboleth"}}'
    - key: REPOSITORY_SERVICE_HOME_AUTH_EXTERNAL_LOGOUT_REDIRECT
      value: '{{ "true"}}'
    - key: REPOSITORY_SERVICE_HOME_AUTH_EXTERNAL_LOGOUT_REDIRECT_URL
      value: '{{edu_sharing_url + "/components/login"}}'
    - key: REPOSITORY_SERVICE_HOME_AUTH_EXTERNAL_LOGOUT_DESTROY_SESSION
      value: "true"
    - key: REPOSITORY_SERVICE_AUTH_EXTERNAL
      value: '{{ "true"}}'
    - key: REPOSITORY_SERVICE_AUTH
      value: '{{ "shibboleth"}}'
    - key: REPOSITORY_SERVICE_AUTH_EXTERNAL_LOGIN
      value: "{{ shibboleth_sp_protected_path}}"
    - key: REPOSITORY_SERVICE_AUTH_EXTERNAL_LOGOUT
      value: '{{ shibboleth_sp_base_path +"/Shibboleth.sso/Logout?return=" +  edu_sharing_url + "/components/login"}}'
    - key: REPOSITORY_SERVICE_AUTH_EXTERNAL_LOGOUT
      value: '{{ shibboleth_sp_base_path +"/Shibboleth.sso/Logout?return=" +  edu_sharing_url + "/components/login"}}'

  security_sso_saml_metadata_url: '{{ edu_sharing_protocol | default("http") }}://{{edu_sharing_host}}/oer/shibboleth/metadata.xml'
```

## Tasks

The `tasks/` directory contains all Ansible tasks:

- `main.yml`: The main entry point for Ansible execution.
- `config-env.yml`: Updates `.env` file with Shibboleth-related configurations.
- `register_override_configuration.yml`: Registers the Shibboleth configuration in `edu-sharing.override.conf`.
- `register_shibboleth_client_config.yml`: Registers the Shibboleth configuration in `client.conf.xml`.
- `register_shibboleth.yml`: Register shibboleth in edu-sharing.
- `unregister.yml`: Removes Shibboleth configurations when `edu_configure_shibboleth` is set to `false`.

## Files

The `files/` directory contains the files:

1. `edu-sharing-sso-context.xml`: The Spring Security configuration file for Shibboleth authentication.
