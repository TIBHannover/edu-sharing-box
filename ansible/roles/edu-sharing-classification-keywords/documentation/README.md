# Ansible Role: edu-sharing-classification-keywords

The `edu-sharing-classification-keywords` role is used dowland and register classification keywords for edu-sharing.

## Implementation

The `edu-sharing-classification-keywords` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-classification-keywords
      tags: 
        - edu-sharing-classification-keywords

```



or we just want to run only the `edu-sharing-classification-keywords` then we run:

```sh
ansible-playbook -v -i <host> ansible/system.yml --tags "edu-sharing-classification-keywords"
```
This will skip other roles and run only the vocabularies role

## Role Variables

The `edu-sharing-classification-keywords` role allows you to customize certain variables according to your requirements. 

Here are the default variables:


```yaml
# Override the default local file 
classification_keywords_force_download: false

# Classification-Keywords-URL (for download)
classification_keywords_url: "https://data.dnb.de/GND/authorities-gnd-sachbegriff_dnbmarc_20240213.mrc.xml.gz"

```

## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `classification-keyword.yml`: Used to download the classification-keywords from  `classification_keywords_url` url and extract the `xml` file into server.
3. `jobs.yml`: It's used to register the classification keywords in edu-sharing
