{% set cups_config_directory = {
    'Linux': '/etc/cups',
    'FreeBSD': '/usr/local/etc/cups',
}.get(grains.kernel) %}

{% set cups_service_name = {
    'Linux': 'cups',
    'FreeBSD': 'cupsd',
}.get(grains.kernel) %}

{{ cups_config_directory }}/client.conf:
  file.managed:
    - source: salt://cups/client.conf

{{ cups_service_name }}:
  service.running:
    - watch:
      - file: {{ cups_config_directory }}/client.conf
