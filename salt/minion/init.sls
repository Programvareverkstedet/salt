{% from "salt/map.jinja" import salt_settings with context %}
{% set pvv_config = salt_settings.config_path+"/minion.d/pvv.conf" %}

salt_minion_config:
  file.managed:
    - name: {{ pvv_config }}
    - source: salt://{{ tpldir }}/minion.d/pvv.conf

salt_minion_service:
  service.running:
    - name: {{ salt_settings.minion_service }}
    - watch:
      - file: {{ pvv_config }}

pvv_salt_cron_job:
  file.managed:
    - name: {{ pillar.cron_daily }}/pvv-salt
    - source: salt://{{ tpldir }}/pvv-salt.cron
    - mode: 755

