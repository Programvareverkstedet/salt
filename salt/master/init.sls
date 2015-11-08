#
# Uppsett på saltmaster-boksen
#

/etc/sudoers.d/saltmaster:
  file.managed:
    - source: salt://salt/master/saltmaster.sudo

/usr/local/sbin/install-ssh-key:
  file.managed:
    - source: salt://salt/master/install-ssh-key

/usr/local/bin/prepare-saltmaster-userdir:
  file.managed:
    - source: salt://salt/master/prepare-saltmaster-userdir

modify_etc_bashrc:
  cmd.wait:
    - name: "grep -q prepare-saltmaster-userdir /etc/bash.bashrc || echo 'if [ -x /usr/local/bin/prepare-saltmaster-userdir ]; then /usr/local/bin/prepare-saltmaster-userdir || exit; fi' >> /etc/bash.bashrc"
    - watch:
      - file: /usr/local/bin/prepare-saltmaster-userdir

/etc/krb5.conf:
  file.managed:
    - source: salt://salt/master/krb5.conf.saltmaster

/etc/salt/master.d/pvv.conf:
  file.managed:
    - source: salt://salt/master/master.d/pvv.conf.py
    - template: py

salt-master:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/salt/master.d/pvv.conf
    - require:
      - pkg: salt-master

salt-master-packages:
  pkg.installed:
    - pkgs:
      - heimdal-clients
      - libpam-krb5
