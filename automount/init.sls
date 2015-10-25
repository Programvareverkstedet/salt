/etc:
  file.recurse:
    - source: salt://automount/etc

/etc/auto.master:
  file.managed:
    - source: salt://automount/auto.master

restart_autofs:
  cmd.wait:
    - name: 'rm -f /etc/auto_master && ln -s auto.master /etc/auto_master && /etc/init.d/autofs restart'
    - watch:
      - file: /etc/auto.master

nfs.packages:
  pkg.installed:
  - pkgs:
    - nfs-common
    - autofs
