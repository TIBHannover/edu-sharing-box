# Ansible Role: edu-sharing-customization

The edu-sharing-customization role is a role used to customize the edu-sharing.

## Implementation

__edu-sharing-customization__ role is included in to the playbook see: [system.yml](../../../system.yml).


```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-customization
      tags: 
        - edu-sharing-customization

```


or we just want to run only the `edu-sharing-customization` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-customization"
```
This will skip other roles and run only the vocabularies role

## Role Variables

__edu-sharing-customization__ role allows you to customize certain variables according to your requirements. Here are the default variables:


```yaml
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
  - key: REPOSITORY_SERVICE_AUTH_EXTERNAL
    value: '{{ "true" if (edu_configure_shibboleth is defined) and (edu_configure_shibboleth)  else ""}}'
  - key: REPOSITORY_SERVICE_AUTH
    value: '{{ "shibboleth" if (edu_configure_shibboleth is defined) and (edu_configure_shibboleth)  else ""}}'
  - key: REPOSITORY_SERVICE_AUTH_EXTERNAL_LOGIN
    value: '{{ "/edu-sharing/shibboleth" if (edu_configure_shibboleth is defined) and (edu_configure_shibboleth)  else ""}}'
  - key: REPOSITORY_SERVICE_AUTH_EXTERNAL_LOGOUT
    value: '{{ shibboleth_sp_base_path +"/Shibboleth.sso/Logout?return=" +  edu_sharing_url + "/components/login" if (edu_configure_shibboleth is defined) and (edu_configure_shibboleth)  else ""}}'


```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `config-cluster`: This directory contains all the task used to override/customize the `repository-service-volume-config-cluster`.
3. `config-edu-sharing`: This directory contains all the task used to override/customize the `repository-service-volume-config-edu-sharing`.
4. `config-node`: This directory contains all the task used to override/customize the `repository-service-volume-config-node`.
5. `adjust_env_variables.yml`: This task is used to override the .env variables in the `.env` file.
6. `jobs.yml`: This task will execute edu-sharing jobs.


[edusharing.yml](../../../group_vars/edusharing.yml) contains other other variables that are nt default and need to be adjusted

## Templates

 The `templates/` directory contains some files we will used to customize edu-sharing.

 It contains: 

 1. `edu-sharing.conf.j2` Used to override the edu-sharing configuration .
 2. `lms.properties.xml.j2` Used to add and configure `lms` into the edu-sharing.
 3. `oersi.properties.xml` Used to add and configure the oersi search index into the edu-sharing
 4. `pixabay.properties.xml` Used to add and configure the pixabay platform into the edu-sharing
 5. `youtube.properties.xml` Used to add and configure the youtube platform into the edu-sharing

