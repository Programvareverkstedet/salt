include:
  - .packages

{% set salt_config_dir = {
    'Linux': '/etc/salt',
    'FreeBSD': '/usr/local/etc/salt',
}.get(grains.kernel) %}

{% set salt_minion_service = {
    'Linux': 'salt-minion',
    'FreeBSD': 'salt_minion',
}.get(grains.kernel) %}

# Was renamed to pvv.conf
{{ salt_config_dir }}/minion.d/environment.conf:
  file.absent

{{ salt_config_dir }}/minion.d/pvv.conf:
  file.managed:
    - source: salt://{{ tpldir }}/minion.d/pvv.conf

{{ salt_minion_service }}:
  service.running:
    - watch:
      - file: {{ salt_config_dir }}/minion.d/environment.conf

{{ pillar.cron_daily }}/pvv-salt:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-salt.cron
    - mode: 755


