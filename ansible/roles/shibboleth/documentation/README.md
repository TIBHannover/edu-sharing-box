# Ansible Role: shibboleth

The `shibboleth` role is used install/uninstall shibboleth in/from your system

## Implementation

The `shibboleth` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  become: yes
  roles:
    - role: shibboleth
      when: install_shibboleth is defined and install_shibboleth
      tags: 
        - shibboleth
```
or we just want to run only the `shibboleth` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "shibboleth"
```
This will skip other roles and run only the shibboleth role

## Tasks

The `tasks/` directory contains all the Ansible tasks.

1. **`main.yml`**: The primary entry task for Ansible playbook execution.
2. **`debianstretch.yml`**: Installs Shibboleth on Debian Stretch.
3. **`debianbuster.yml`**: Installs Shibboleth on Debian Buster.
4. **`debian-from-bullseye.yml`**: Installs Shibboleth on Debian Bullseye.
5. **`migrate-from-switchaai.yml`**: Migrates Shibboleth to SwitchAAI.
6. **`shibbolethconfig.yml`**: Configures Shibboleth for Edu-sharing.

---

## Templates

The `templates/` directory contains template files used for configuration.

1. **`attrChecker.html.j2`**: HTML template used to render on a browser.
2. **`dfn-aai-shibboleth2.xml.j2`**: DFN-AAI XML configuration template.
3. **`shib.conf.j2`**: Shibboleth Apache configuration template.

---

## Files

The `files/` directory contains essential static files.

1. **`attribute-map.xml`**: XML file for attribute configuration.
2. **`generate-cert.sh`**: Script for generating certificates for DFN-AAI configuration.
3. **`shib-error.css`**: CSS file for customizing Shibboleth error pages.



## Running Shibboleth with Ansible

This section explains how to execute the Shibboleth role with Ansible, covering general usage, running with specific tags, and skipping tasks using tags.

### Running only the shibboleth


```bash
 ansible-playbook -v -i <host> ansible/system.yml --tags "shibboleth"
```

To run the entire Shibboleth role, without running other roles.

### Running only the shibboleth-configuration

```bash
 ansible-playbook -v -i <host> ansible/system.yml --tags "shibboleth"  --skip-tags "shibboleth-platform-*"
```

To run the entire Shibboleth role, without running other roles, skipping installation, IF we want to update some configuration, but we don't want to do an installation