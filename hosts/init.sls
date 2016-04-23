/etc/hosts.allow:
  file.managed:
    - source: salt://{{ tpldir }}/hosts.allow.jinja
    - template: jinja

/etc/hosts.deny:
  file.managed:
    - source: salt://{{ tpldir }}/hosts.deny.jinja
    - template: jinja
