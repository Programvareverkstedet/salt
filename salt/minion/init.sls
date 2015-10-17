/etc/salt/minion.d/environment.conf:
  file.managed:
    - source: salt://salt/minion/minion.d/environment.conf

salt-minion:
  service.running:
    - watch:
      - file: /etc/salt/minion.d/environment.conf
{% if grains['osarch'] != 'ia64' %}
    - require:
      - pkg: salt-minion
  pkg.installed: []
{% endif %}
