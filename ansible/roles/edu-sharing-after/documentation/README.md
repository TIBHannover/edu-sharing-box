# Ansible Role: edu-sharing-after

The `edu-sharing-after` role to do some configuration or installation that may need after the edu-sharing is up, and running, and it will be executed all time after all the roles are finished.

## Implementation

The `edu-sharing-after` role is included in the playbook [system.yml](../../../system.yml).

```yaml
- hosts: edusharing
  roles:
    - role: edu-sharing-after
      tags: 
        - edu-sharing-after

```
## Tasks

The `tasks/` directory contains all the ansible tasks.

1. `main`: The main task or entry task for ansible.
2. `update_edu-sharing_client_config`: Used to update the `client.conf.xml`
