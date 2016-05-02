# passwd.pvv hentes via salt.pillar.file_tree-modulen, og selve filen
# ligger i pillar/files/nodegroups/all/files/passwd.pvv

{% if grains['kernel'] == 'Linux' %}
# User merge-{passwd,group}.pl on Linux, because it is faster and works with versions
# of salt older than 2016.3 (older versions do not support unicode in GECOS)
include:
  - .usersync-perl
{% else %}
# Use usersync.sls on any other OS, because it is cross-platform
include:
  - .usersync-salt
{% endif %}

/etc/netgroup:
  file.managed:
    - source: salt://{{ tpldir }}/netgroup
