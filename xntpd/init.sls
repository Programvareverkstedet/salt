/etc/ntp.conf:
  file.managed:
    - source: salt://xntpd/ntp.conf
