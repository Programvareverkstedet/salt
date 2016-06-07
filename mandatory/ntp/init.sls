/etc/ntp.conf:
  file.managed:
    - source: salt://{{ tpldir }}/ntp.conf

ntp:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/ntp.conf
