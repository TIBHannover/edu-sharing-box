# OPENCAST-IMPORTER

https://github.com/virtUOS/edusharing-opencast-importer ist ein Tool um Opencast-Videos in edu-sharing zu importieren (verlinken).

Durch die Aktivierung des opencast-Features in den Ansible-Skripten wird der Import über das Tool eingerichtet - zeitgesteuert täglich via crontab.

Konfiguration siehe [group_vars/opencast.yml](ansible/group_vars/opencast.yml)

Host muss zur Gruppe *opencast* hinzugefügt werden.
