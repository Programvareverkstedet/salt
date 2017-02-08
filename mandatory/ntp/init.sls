{% set ntp_service = {
    'Debian': 'ntp',
    'FreeBSD': 'ntp',
    'Arch': 'ntpd',
}.get(grains.os_family) %}
/etc/ntp.conf:
  file.managed:
    - source: salt://{{ tpldir }}/ntp.conf

{{ ntp_service }}:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/ntp.conf
