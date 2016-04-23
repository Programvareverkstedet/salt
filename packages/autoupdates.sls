# pvvpakke brukes hvis og bare hvis vi ikke ruker pkgsync

{{ pillar.cron_daily }}/pvvpakke:
{% if 'pkgsync' in grains['roles'] and grains['kernel'] == 'Linux' %}
  file.absent
{% else %}
  file.managed:
    - source: salt://{{ tpldir }}/pvvpakke.sh
    - mode: 700
{% endif %}

