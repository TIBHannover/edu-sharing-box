# Connect content from OERSI

The content from the OER Search Index can be connected via plugin and will be fetched dynamically.

The feature is activated per default and can be tested in the Vagrant VM. It can be activated/deactivated via feature-toggle `connect_content_oersi` (see [edusharing.yml](ansible/group_vars/edusharing.yml)).

The OERSI-plugin can be configured via [oersi-mds-override-file](ansible/roles/edu-sharing/files/mds_oersi_override_example.xml) (how to display, how to fetch data, ...) and the OERSI-instance that should be connected via [oersi-ansible-variables](ansible/roles/edu-sharing/defaults/main.yml).
