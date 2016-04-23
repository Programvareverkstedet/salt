# passwd.pvv hentes via salt.pillar.file_tree-modulen, og selve filen
# ligger i pillar/files/nodegroups/all/files/passwd.pvv

{% if grains['kernel'] == 'Linux' %}
# User merge-{passwd,group}.pl on Linux, because it is faster and works with versions
# of salt older than 2016.3 (older versions do not support unicode in GECOS)

/etc/passwd.pvv:
  file.managed:
    - contents_pillar: files:passwd:passwd.pvv

/usr/local/sbin/merge-passwd.pl:
  cmd.wait:
    - name: /usr/local/sbin/merge-passwd.pl {{ pillar['passwd']['min_uid'] }}
    - watch:
      - file: /etc/passwd.pvv
      - file: /usr/local/sbin/merge-passwd.pl
  file.managed:
    - source: salt://{{ tpldir }}/merge-passwd.pl
    - mode: 755

/etc/group.pvv:
  file.managed:
    - contents_pillar: files:passwd:group.pvv

/usr/local/sbin/merge-group.pl:
  cmd.wait:
    - name: /usr/local/sbin/merge-group.pl {{ pillar['passwd']['min_gid'] }}
    - watch:
      - file: /etc/group.pvv
      - file: /usr/local/sbin/merge-group.pl
  file.managed:
    - source: salt://{{ tpldir }}/merge-group.pl
{% else %}
# Use usersync.sls on any other OS, because it is cross-platform
include:
  - .usersync
{% endif %}

/etc/netgroup:
  file.managed:
    - source: salt://{{ tpldir }}/netgroup
