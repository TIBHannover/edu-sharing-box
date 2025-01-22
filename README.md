# edu-sharing-box


Dieses Projekt bietet die Möglichkeit, ein edu-sharing mit minimalem Aufwand in einer virtuellen Maschine aufzusetzen. Voraussetzung ist die Installation von
[Git](https://git-scm.com/downloads),  [Vagrant](https://www.vagrantup.com/downloads.html) und [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

## Installation

Die folgenden Schritte im Terminal (Linux/macOS) oder in der GitBash (Windows) ausführen.
```
git clone https://github.com/TIBHannover/edu-sharing-box.git
cd edu-sharing-box
vagrant up
```
Wenn die Installation durchgelaufen ist (einige Minuten, abhängig von der Download-Geschwindigkeit) kann edu-sharing im Browser aufgerufen werden mit

<http://192.168.98.101/edu-sharing>
Die Anmeldung am edu-sharing erfolgt in diesem Beispiel noch vereinfacht mit _admin_/_admin_

Die Anmeldung an der VM via SSH erfolgt in diesem Beispiel noch vereinfacht und ohne Passwort mit dem Benutzer "vagrant". Der Benutzer hat das sudo-Recht.
```
vagrant ssh
```

## Update

### edu-sharing aktualisieren

* Update Notes prüfen unter https://docs.edu-sharing.com/confluence/edp/en/updating-en/updating-the-repository und ggf. Prozess anpassen
* *edu_version* und *edu_sharing_archive_url* anpassen in den edusharing-vars
* playbook ausführen

### renderingservice aktualisieren

* Update Notes prüfen unter https://docs.edu-sharing.com/confluence/edp/en/updating-en/updating-the-rendering-service und ggf. Prozess anpassen
* *esrender_version* anpassen in den renderingservice-vars
* playbook ausführen

## DFN-AAI / Shibboleth Integration

Siehe [SHIBBOLETH.md](SHIBBOLETH.md)

## Documentation

Each role in the edu-sharing playbook comes with its own detailed documentation, covering various aspects such as updates, included components, and more. Below are the links to the documentation for each role:
 
- [edu-sharing-init](ansible/roles/edu-sharing-init/documentation/README.md): This role initializes the edu-sharing.
- [edu-sharing-migration](ansible/roles/edu-sharing-migration/documentation/README.md):  This role handles migration tasks for edu-sharing.
- [edu-sharing-customization](ansible/roles/edu-sharing-customization/documentation/README.md): This role allows customization of the edu-sharing platform.
- [edu-sharing-rendering-service](ansible/roles/edu-sharing-rendering-service/documentation/README.md): This role manages the rendering service for edu-sharing.
- [edu-sharing-search-elastic](ansible/roles/edu-sharing-search-elastic/documentation/README.md): This role deals with the elastic search functionality within edu-sharing.
- [edu-sharing-classification-keywords](ansible/roles/edu-sharing-classification-keywords/documentation/README.md): This role handles keyword classification tasks.
- [edu-sharing-mirror-vocabs](ansible/roles/edu-sharing-mirror-vocabs/documentation/README.md): This role manages the mirroring of vocabularies.
- [edu-sharing-backup](ansible/roles/edu-sharing-backup/documentation/README.md): This role is responsible for backing up edu-sharing data.
- [edu-sharing-restore](ansible/roles/edu-sharing-restore/documentation/README.md): This role handles the restoration of edu-sharing data.
- [edu-sharing-notification](ansible/roles/edu-sharing-notification/documentation/README.md): This role handles the edu-sharing notification service.
- [edu-sharing-custom-amp](ansible/roles/edu-sharing-custom-amp/documentation/README.md): This role handles the alfresco AMPs files.

These documentation files provide detailed instructions and guidelines for using each role effectively.