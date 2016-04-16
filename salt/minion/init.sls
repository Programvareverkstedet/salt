{% set salt_config_dir = {
    'Linux': '/etc/salt',
    'FreeBSD': '/usr/local/etc/salt',
}.get(grains.kernel) %}

{{ salt_config_dir }}/minion.d/environment.conf:
  file.managed:
    - source: salt://salt/minion/minion.d/environment.conf

salt-minion:
  service.running:
    - watch:
      - file: {{ salt_config_dir }}/minion.d/environment.conf
{% if grains['osarch'] != 'ia64' %}
    - require:
      - pkg: salt-minion
  pkg.installed: []
{% endif %}

/etc/cron.daily/pvv-salt:
  file.managed:
    - source: salt://salt/minion/pvv-salt.cron
    - mode: 755
{% if grains['osarch'] != 'ia64' %}
    - require:
      - pkg: salt-minion
{% endif %}
