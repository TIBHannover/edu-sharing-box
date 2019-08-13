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
