# Edu-sharing Connector
The [edu-sharing connector](https://github.com/edu-sharing/edu-connector) allows editing of various file formats like html, h5p or other documents from LibreOffice and Microsoft Office, including **word, excel, powerpoint**.


## Installing 

to install **edu-sharing connector**  in server you need enable, by making true the variable  `enable_edu_connector: true` (default is **false**)  in [*/group_vars/all.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/group_vars/all.yml)

In same file, You can enable/disable edu-connector modules like H5P,TINYMCE ( default all modules are enabled)

```yml
  # Edu-connector enabled modules (default active all modules)
    edu_connector_enable_modules:
      h5p: true
      only_office: true
      tiny_mce: true
```
 by default edu-connector will be installed in same host with render-service host, but we can separate it if we want to use a dedicate server for this application.

```yml
  # the host where edu-connector will be installed
  edu_connector_host: '{{ esrender_host }}'
  # the edu-connector full URL
  edu_connector_url: '{{ edu_sharing_protocol | default("http") }}://{{ edu_connector_host }}/eduConnector'
```

## Role Variables

Php and composer variables are listed in [*ansible/roles/edu-connector/defaults/main.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/roles/edu-connector/defaults/main.yml)  along with default value.

 - ```yml 
       ---
        #  php version
        php_version: 'php'
        # php packages list 
        php_packages:
        - "{{php_version}}"
        - "{{php_version}}-cli"
        - "{{php_version}}-gd"
        - "{{php_version}}-curl"
        - "{{php_version}}-mysql"
        - "{{php_version}}-pgsql"
        - "{{php_version}}-xml"
        - "{{php_version}}-zip"
        - "{{php_version}}-soap"
        - "{{php_version}}-mbstring"
        - "{{php_version}}-dom"
        - "{{php_version}}-iconv"
        - "{{php_version}}-fileinfo"
        - "{{php_version}}-sockets"
        - "{{php_version}}-wddx"
        - "{{php_version}}-date"
        - "{{php_version}}-common"
        - "{{php_version}}-json"
        - "{{php_version}}-fpm"
        - "{{php_version}}-sqlite3"
        - "{{php_version}}-intl"


        # php composer URL (default last version)
        phar_composer_url: "https://getcomposer.org/download/latest-stable/composer.phar"

          ```

You can override them using file:  [*ansible/group_vars/educonnector.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/group_vars/educonnector.yml), along with other variables.



**educonnector.yml**: 
		
  ```yml   
        ---
        edu_connector_vhost: true

        edu_connector_version: develop
        edu_connector_archive_url: 'https://github.com/edu-sharing/edu-connector/archive/{{edu_connector_version}}.tar.gz' 
        edu_connector_download_dir: "{{base_dir}}/edu_connector_{{edu_connector_version}}"


        # download even if exist 
        edu_connector_force_download: yes 


        # database configuration
        edu_connector:
        db_host: 'localhost'
        db_name: 'eduConnector'
        db_user: 'eduConnector'
        db_password: 'eduConnector'

        # will remove existing files and clean DB (Db will be backup in eduConnector_backup directory)
        edu_connector_remove_existing: false

        # Download  file here : https://github.com/edu-sharing/edu-connector/blob/develop/config.dist.php, and make all the necessary changes to it.
        # add the path here to your config.php file here.
        edu_connector_config_path: 

        #  edu-sharing credentials 
        edu_connector_credentials:
        edu_sharing_user: 'admin'
        edu_sharing_password: '{{alf_password}}'
        edu_sharing_client_id: 'eduApp'
        edu_sharing_client_secret: 'secret'

```