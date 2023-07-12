# ONLYOFFICE Docs™ Community Edition - DOCUMENTATION

[**ONLYOFFICE Docs**](https://www.onlyoffice.com/) is an online office suite comprising viewers and editors for texts, spreadsheets and presentations, fully compatible with Office Open XML formats: .docx, .xlsx, .pptx and enabling collaborative editing in real time.


## System requirements

- **CPU** dual core 2 GHz or better
- **RAM** 4 GB or more
- **HDD** at least 40 GB of free space
- **SWAP** at least 4 GB, but depends of the host OS. More is - better
- **OS** amd64 Linux distribution with kernel version 3.10 or - later

**Additional requirements**
- **Docker**: any version supported by Docker team

## Installing 

to install **OnlyOffice document server**  in server you need enable, by making true the variable __example `enable_only_office: true`__ (default is **false**) in [*/group_vars/all.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/group_vars/all.yml)
 
## Role Variables

Exist some default variables that are not necessary to be override, but if someone want to override them, than they can, by adding those variables to  [*ansible/group_vars/onlyoffice.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/group_vars/onlyoffice.yml), for more info see [*ansible/roles/onlyoffice/defaults/main.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/roles/onlyoffice/defaults/main.yml)  along with default value.

 - ```yml

      # since for now we support only postgres,we will leave as default variable
      onlyoffice_database_type: postgres
      onlyoffice_install_dir:  "{{base_dir}}/onlyoffice_{{onlyoffice_version | default('latest',true)|replace('.','_')}}"
      onlyoffice_run_command: 'sg docker -c "docker compose up -d"'

      # internal port
      onlyoffice_port: 9600
      # virtual path used by apache server
      onlyoffice_v_path: "/onlyoffice"

  
   ```

Main variables than can be change are located in:  [*ansible/group_vars/onlyoffice.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/group_vars/onlyoffice.yml)

**example**: 
		

 - ```yml   
      # OnlyOffice variable

      #onlyofficeor Version (Docker)
      onlyoffice_version: latest
      onlyoffice_jwt_enabled: true # true/false
      onlyoffice_jwt_secret: "my_jwt_secret" # secret jwt token

      # Database type for now supported only by postgres
      # database configuration
      onlyoffice_database:
        db_name: 'onlyoffice'
        db_user: 'onlyoffice'
        db_password: 'onlyoffice'


      # Rabbit MQ Configuration
      onlyoffice_rabbitmq_version:  latest
      onlyoffice_rabbitmq_port:  5672
      onlyoffice_rabbitmq_management_port:  15672
      onlyoffice_rabbitmq_user: onlyoffice
      onlyoffice_rabbitmq_pass: onlyoffice
      onlyoffice_rabbitmq_vpath: /
   	```

## OnlyOffice Help links

 1.  [Installing document server in docker](https://helpcenter.onlyoffice.com/installation/docs-community-docker-compose.aspx)
 2. [Integration examples](https://api.onlyoffice.com/editors/demopreview)
 3. [Try now ](https://api.onlyoffice.com/editors/try)
 4. [customize the editor interface](https://api.teamlab.info/editors/config/editor/customization)
 5. [Advanced parameters](https://api.teamlab.info/editors/advanced)
