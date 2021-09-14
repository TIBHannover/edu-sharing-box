# ONLYOFFICE Docs™ Community Edition - DOCUMENTATION

[**ONLYOFFICE Docs**](https://www.onlyoffice.com/) is an online office suite comprising viewers and editors for texts, spreadsheets and presentations, fully compatible with Office Open XML formats: .docx, .xlsx, .pptx and enabling collaborative editing in real time.


## System requirements

**Hardware**
-   **CPU**: dual core  **2 GHz**  or better    
-   **RAM** : **2 GB**  or more    
-   **HDD**: at least  **40 GB**  of free space    
-   **Additional requirements**:  at least  **4 GB**  of swap    
-   OS 64-bit  **Debian**,  **Ubuntu**  or other compatible distribution with kernel version 3.13 or later    
-   **Additional requirements**:    
    -   **PostgreSQL**: version  **9.1**  or later
    -   **NGINX**: version  **1.3.13**  or later
    -   **libstdc++6**: version  **4.8.4**  or later
    -   **RabbitMQ**

##  Configuring OnlyOffice Docs with non-standard port

When enabling  [**onlyoffice document server**](https://helpcenter.onlyoffice.com/installation/docs-community-install-ubuntu.aspx), usually it's recommended to install it on a separate server, as it provides a complete webserver bundle which may conflict with an existing web server setup.

Still, it's possible to have OnlyOffice Docs installed on the same server, since OnlyOffice document server comes with **Nginx** (it is configured automatically during the installation process), if you already run Apache you can have both on the same system, as long as they don't use the same set of ports.

## Installing 

to install **OnlyOffice document server**  in server you need enable, by making true the variable __example `enable_only_office: true`__ (default is **false**) in [*/group_vars/all.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/group_vars/all.yml)
 
## Role Variables

All variables are listed in [*ansible/roles/onlyoffice/defaults/main.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/roles/onlyoffice/defaults/main.yml)  along with default value.

 - ```yml 
   onlyoffice_ds_port: 80  # webserver port 
   onlyoffice_start_example_service: false  # activate GUI for example service
   onlyoffice_docservice_port: 8000  # document service port
   onlyoffice_example_port: 3000   # GUI example port 
   onlyoffice_onlyoffice_spellchecker_port: 8082   # spell checker port
   
   # for more details, see https://api.onlyoffice.com/editors/signature/ 
   onlyoffice_jwt_enabled: false  # enable/disable jwt 
   onlyoffice_jwt_header: "Authorization"   # jwt Header
   onlyoffice_jwt_secret: ""    # jwt secret code 
   
   
   # database configuration  
   onlyoffice_db_type: "postgres"  # database type recommended to use postgres
   onlyoffice_db_host: "localhost"  # database host
   onlyoffice_db_name: "onlyoffice" # database name 
   onlyoffice_db_user: "onlyoffice"  # database user 
   onlyoffice_db_password: "onlyoffice"  # database password 
   onlyoffice_db_port: "5432"  # database port
   

   # RabbitMq configuration 
   onlyoffice_rabbitmq_host: localhost   # rabbitMQ host 
   onlyoffice_rabbitmq_user: onlyoffice  # rabbitMQ user 
   onlyoffice_rabbitmq_pass: onlyoffice  # rabbitMQ password 
   onlyoffice_rabbitmq_vpath: /          # rabbitMQ virtualPath  
   onlyoffice_rabbitmq_port: 5672        # rabbitMQ port
   

   # url connection with rabbitMQ 
   onlyoffice_rabbitmq_url: "amqp://{{ onlyoffice_rabbitmq_user}}:{{ onlyoffice_rabbitmq_pass}}@{{
   onlyoffice_rabbitmq_host}}:{{ onlyoffice_rabbitmq_port}}{{
   onlyoffice_rabbitmq_vpath}}" ```

You can override them using file:  [*ansible/group_vars/onlyoffice.yml*](https://github.com/TIBHannover/edu-sharing-box/blob/master/ansible/group_vars/onlyoffice.yml)  

**example**: 
		

 - ```yml   
   # installing rabbitMQ server		
   # candidates for rabbitmq_version is 3.7.18 || or check by running: apt-cache policy rabbitmqserver 		
   rabbitmq_version: "3.7.18" 	# installing rabbitMQ version	
   rabbitmq_state: started 		# state of rabbitMQ
   rabbitmq_enabled: true  # enable/disable rabbitMQ
   
   # by default we are installing onlyoffice in same server with renderservice so we need to override the port  		
   # default is 80 
   onlyoffice_ds_port: 8081  
   
   # OnlyOffice DB  variable  override		
   onlyoffice_db_name: "onlyoffice"
   onlyoffice_db_user: "onlyoffice" 		
   onlyoffice_db_password:"onlyoffice"
   onlyoffice_db_port: "{{postgresql_port}}"   
   
   # OnlyOffice rabbitMQ variable override
   onlyoffice_rabbitmq_user: onlyoffice
   onlyoffice_rabbitmq_pass:onlyoffice
   onlyoffice_rabbitmq_vpath: / 
   
   	```

## OnlyOffice Help links

 1.  [Installing document server in local server](https://helpcenter.onlyoffice.com/installation/docs-community-install-ubuntu.aspx)
 2. [Integration examples](https://api.onlyoffice.com/editors/demopreview)
 3. [Try now ](https://api.onlyoffice.com/editors/try)
 4. [customize the editor interface](https://api.teamlab.info/editors/config/editor/customization)
 5. [Advanced parameters](https://api.teamlab.info/editors/advanced)
