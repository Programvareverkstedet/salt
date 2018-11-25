{% set ntp_service = {
    'Debian': 'ntp',
    'FreeBSD': 'ntp',
    'Arch': 'ntpd',
    'RedHat': 'ntpd',
}.get(grains.os_family) %}
/etc/ntp.conf:
  file.managed:
    - source: salt://{{ tpldir }}/ntp.conf

{% if ntp_service %}
{{ ntp_service }}:
  pkg.installed:
    - pkgs:
      - ntp
  service.running:
    - watch:
      - file: /etc/ntp.conf
{% endif %}
