#
# Uppsett på saltmaster-boksen
#

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

/etc/salt/master.d/environments.conf:
  file.managed:
    - source: salt://salt/master/master.d/environments.conf.py
    - template: py

salt-master:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/salt/master.d/environments.conf
    - require:
      - pkg: salt-master
