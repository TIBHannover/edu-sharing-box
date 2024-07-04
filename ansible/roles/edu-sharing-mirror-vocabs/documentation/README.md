# Ansible Role: edu-sharing-mirror-vocabs

The `edu-sharing-mirror-vocabs` role is used generate mirror-vocabularies for edu-sharing.

## Implementation

The `edu-sharing-mirror-vocabs` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-mirror-vocabs
      tags: 
        - edu-sharing-mirror-vocabs

```



or we just want to run only the `edu-sharing-mirror-vocabs` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-mirror-vocabs"
```
This will skip other roles and run only the vocabularies role

## Role Variables

The `edu-sharing-mirror-vocabs` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
---
mirror_vocabularies:
  # - url: "https://w3id.org/kim/hochschulfaechersystematik/scheme.json"
  #   target_directory: "/var/www/oer/vocabs-mirror"
  # - url: "https://w3id.org/kim/hcrt/scheme.json"
  #   target_directory: "/var/www/oer/vocabs-mirror"

mirror_vocabs_hour: "4"


```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `mirror-vocabs.yml`: This task is used to copy an shell script that will generate vocabularies.

## Templates

The `templates/` directory contains the shell script used generate the vocabs.