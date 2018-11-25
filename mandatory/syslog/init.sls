# PVV har standardisert på rsyslog

{% set syslog_service = {
    'Debian': 'rsyslog',
    'FreeBSD': 'syslogd',
    'Arch': 'rsyslog',
    'RedHat': 'rsyslog',
}.get(grains.os_family) %}

{% set syslog_config_file = {
    'Debian': '/etc/rsyslog.d/pvv.conf',
    'FreeBSD': '/etc/syslog.conf',
    'Arch': '/etc/rsyslog.conf',
    'RedHat': '/etc/rsyslog.d/pvv.conf',
}.get(grains.os_family) %}

{% if syslog_config_file and syslog_service %}
{{ syslog_config_file }}:
{% if syslog_service == 'rsyslog' %}
  file.managed:
    - source: salt://{{ tpldir }}/rsyslog_pvv.conf
{% else %}
  file.blockreplace:
    - source: salt://{{ tpldir }}/rsyslog_pvv.conf
    - marker_start: '### BEGIN PVV-specific syslog config ###'
    - marker_end: '### END PVV-specific syslog config ###'
    - prepend_if_not_found: True
{% endif %}

{{ syslog_service }}:
  service.running:
    - enable: True
    - watch:
      - file: {{ syslog_config_file }}
{% endif %}
