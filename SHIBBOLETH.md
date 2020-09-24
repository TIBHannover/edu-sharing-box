# DFN-AAI / Shibboleth Integration

Es ist möglich den Single-Sign-On (SSO) Zugang via DFN-AAI (Shibboleth) automatisiert zu konfigurieren. Dies umfasst die Installation von shibboleth und die Konfiguration von edu-sharing.

## Voraussetzungen

* Anmeldung des Service Provider (SP) bei DFN AAI: [https://doku.tid.dfn.de/de:registration](https://doku.tid.dfn.de/de:registration)
* Daten des SP in die Metadaten der DFN-AAI Testföderation eintragen
     * Unter https://www.aai.dfn.de/verwaltung/metadaten/ => "neuen SP anlegen"
     * Eigene Daten einpflegen bzw URL zum eigenen SP angeben (zB http://192.168.98.101/Shibboleth.sso/Metadata)
     * Benötigte Attribute
     ```
     ... FriendlyName="eduPersonScopedAffiliation"  ... isRequired="true"
     ... FriendlyName="uid"                         ... isRequired="true"
     ... FriendlyName="mail"                        ... isRequired="true"
     ... FriendlyName="eduPersonUniqueId"           ... isRequired="true"
     ... FriendlyName="sn"                          ... isRequired="true"
     ... FriendlyName="givenName"                   ... isRequired="true"
     ... FriendlyName="o"                           ... isRequired="true"

     ```

## Unterstützte Systeme

* Debian Stretch (9)
* Debian Buster (10)

Ansible-Skripte für weitere Systeme können unter [ansible/roles/shibboleth/tasks](ansible/roles/shibboleth/tasks) hinzugefügt werden. Eine gute Beschreibung der Installation liefert [SWITCHaai](https://www.switch.ch/aai/guides/sp/installation/). Beiträge sind sehr willkommen - einfach einen Pull Request erstellen.

## Konfiguration

* Ansible Inventory erstellen, dass die (mandatory) Variablen aus [ansible/group_vars/shibboleth.yml](ansible/group_vars/shibboleth.yml) setzt.
* Zertifikate in **_shibboleth_sp_credential_files_**: Service Provider können selbst-signierte Zertifikate verwenden.
     * Siehe [https://doku.tid.dfn.de/de:certificates#informationen_fuer_service_provider](https://doku.tid.dfn.de/de:certificates#informationen_fuer_service_provider)
     * Diese Zertifikate müssen vor der Aufnahme in die DFN-AAI Produktivumgebung verifiziert werden.
     * Zertifikaterstellung s.u.
     
## selbst-signiertes Zertifikat erstellen

* Ein selbst-signiertes Zertifikat kann mit folgenden Methoden erstellt und eingebunden werden:
     * (Empfohlen) Erstellen des Zertifikates mit dem Skript [ansible/roles/shibboleth/files/generate-cert.sh](ansible/roles/shibboleth/files/generate-cert.sh). Dann generiertes cert+key eintragen in **_shibboleth_sp_credential_files_**.
     * (Alternative) wird die Ansible-Variable **_shibboleth_sp_credential_files_** bei der Installation leer gelassen, so werden automatisch cert und key generiert unter _/etc/shibboleth/tmp-cert.pem_ und _/etc/shibboleth/tmp-key.pem_. Diese können dann zB mit scp kopiert werden und im Inventory unter **_shibboleth_sp_credential_files_** fest eingebunden werden
     ```
     scp -i ~/.vagrant.d/insecure_private_key vagrant@192.168.98.101:/etc/shibboleth/tmp*.pem .
     ```
     Nachteil: Erstellung der Zertifikate geht erst während/nach der Installation.
* Zur Beschreibung der verwendeten Methoden siehe [SWITCHaai keygen](https://www.switch.ch/aai/guides/sp/configuration/#4) und [SWITCHaai openssl certificate generation](https://www.switch.ch/aai/support/certificates/embeddedcerts-requirements-appendix-a/)

## Zertifikatswechsel

Siehe [https://doku.tid.dfn.de/de:certificates#zertifikatstausch](https://doku.tid.dfn.de/de:certificates#zertifikatstausch).

Die Reihenfolge der _CredentialResolver_ in der `shibboleth2.xml` ist durch die Reihenfolge in **_shibboleth_sp_credential_files_** bestimmt.

* Neues Zertifikat erstellen und verifizieren lassen.
* Eintragen des neuen Zertifikates am Ende von **_shibboleth_sp_credential_files_** und Update via Playbook ausrollen.
* Veröffentlichung des neuen Zertifikates (zusätzlich) in den Föderationsmetadaten.
* 24 Stunden warten.
* Das neue Zertifikat an den Anfang von **_shibboleth_sp_credential_files_** setzen, das alte ans Ende und Update via Playbook ausrollen.
* Das alte Zertifikat aus den Föderationsmetadaten entfernen.
* 24 Stunden warten.
* Entfernen des alten Zertifikates aus **_shibboleth_sp_credential_files_** und Update via Playbook ausrollen.

## Bemerkungen
* Die Konfiguration hier ist auf DFN-AAI ausgelegt. Es ist jedoch auch möglich eine eigene Shibboleth-Konfiguration zu verwenden indem eigene Templates für die Konfigurationsdateien verwendet werden (die Pfade der Dateien sind konfigurierbar).