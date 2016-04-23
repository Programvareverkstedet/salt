/etc/shells:
  file.managed:
    - source: salt://{{ tpldir }}/shells

/etc/resolv.conf:
  file.managed:
    - source: salt://{{ tpldir }}/resolv.conf

/etc/krb5.conf:
  file.managed:
    - source: salt://{{ tpldir }}/krb5.conf
