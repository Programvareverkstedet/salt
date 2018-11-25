{% set cups_config_directory = {
    'Linux': '/etc/cups',
    'FreeBSD': '/usr/local/etc/cups',
}.get(grains.kernel) %}

{% set cups_service_name = {
    'Arch': 'org.cups.cupsd',
    'FreeBSD': 'cupsd',
}.get(grains.os_family, 'cups') %}

cups:
  pkg.installed

{{ cups_config_directory }}/client.conf:
  file.managed:
    - source: salt://{{ tpldir }}/client.conf
    - require:
      - pkg: cups

cups_service:
  service.running:
    - name: {{ cups_service_name }}
    - watch:
      - file: {{ cups_config_directory }}/client.conf
    - require:
      - pkg: cups

# FIXME: Er denne i bruk etter at vi fikk CUPS?
/etc/lpd.conf:
  file.managed:
    - source: salt://{{ tpldir }}/lpd.conf

# FIXME: Er denne i bruk etter at vi fikk CUPS?
/etc/printcap:
  file.managed:
    - source: salt://{{ tpldir }}/printcap
