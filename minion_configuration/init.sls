salt-minion:
  service:
    - running
    - enable: True
    # Restarts the service if the file is altered:
    - watch:
      - file: /etc/salt/minion
/etc/salt/minion:
  file.managed:
    - source: salt://minion_configuration/minion
    - user: root
    - group: root
    - mode: 644
    # Specifies that the file is a jinja template,
    # and that the variables in the template are to
    # be set to the values given for them in the
    # context section:
    - template: jinja
    - context:
      saltmaster: lommel.pvv.ntnu.no
      timer: 4 
