/etc/ntp.conf:
  file.managed:
    - source: salt://{{ tpldir }}/ntp.conf
