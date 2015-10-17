/etc/hosts.allow:
  file.managed:
    - source: salt://hosts/hosts.allow.jinja
    - template: jinja

/etc/hosts.deny:
  file.managed:
    - source: salt://hosts/hosts.deny.jinja
    - template: jinja
