{% set salt_config_dir = {
    'Linux': '/etc/salt',
    'FreeBSD': '/usr/local/etc/salt',
}.get(grains.kernel) %}

{% set salt_minion_service = {
    'Linux': 'salt-minion',
    'FreeBSD': 'salt_minion',
}.get(grains.kernel) %}

{{ salt_config_dir }}/minion.d/environment.conf:
  file.managed:
    - source: salt://salt/minion/minion.d/environment.conf

{{ salt_minion_service }}:
  service.running:
    - watch:
      - file: {{ salt_config_dir }}/minion.d/environment.conf

/etc/cron.daily/pvv-salt:
  file.managed:
    - source: salt://salt/minion/pvv-salt.cron
    - mode: 755
