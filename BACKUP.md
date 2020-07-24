# Backup einrichten

Backup Ansible-Variablen im Inventory-File setzen (siehe [ansible/group_vars/all.yml](ansible/group_vars/all.yml))

* **backup_process_state**: `present` - um das Backup zu aktivieren
* **backup_db_user**: \<DB-USER-BACKUP\> - username des DB-users, der das Backup durchführen soll (wird angelegt) 
* **backup_db_password**: \<DB-USER-PASSWORD\>
* **backup_schedule_hour**: \<HOUR\> - Stunde zu der das Backup erstellt wird (via Crontab)
* **backup_path**: '\<BACKUP-PATH\>' - Verzeichnis in dem das fertige Backup gespeichert wird

Vom Backup berücksichtigt wird
* Alfresco Datenbank (PSQL)
* Alfresco Datenverzeichnis

**Bemerkung**: Die Sicherung einer MariaDB/MySQL Alfresco Datenbank wird derzeit nicht unterstützt!

# Backup-Daten wiederherstellen
Die folgenden Schritte durchführen

```
# Stop Tomcat
~/bin/tomcat.sh stop
```

```
# Aktuelle Daten löschen
rm -rf ~/alfresco-community-distribution-201707/alf_data
sudo -u postgres psql -c 'DROP DATABASE <alfresco-db>;'
```

```
# Daten wiederherstellen
unpigz -cv ~/backup/db-dump.sql.gz > ~/backup/db-dump.sql
sudo -u postgres psql -f ~/backup/db-dump.sql
tar xzf ~/backup/alfresco.tar.gz --directory ~/
```

```
# Start Tomcat
~/bin/tomcat.sh start
```
