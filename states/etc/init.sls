/etc/shells:
  file.managed:
    - source: salt://etc/shells

/etc/resolv.conf:
  file.managed:
    - source: salt://etc/resolv.conf

/etc/krb5.conf:
  file.managed:
    - source: salt://etc/krb5.conf
