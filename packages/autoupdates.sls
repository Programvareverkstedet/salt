# pvvpakke brukes hvis og bare hvis vi ikke ruker pkgsync

/etc/cron.daily/pvvpakke:
{% if 'pkgsync' in grains['roles'] and grains['kernel'] == 'Linux' %}
  file.absent
{% else %}
  file.managed:
    - source: salt://packages/pvvpakke.sh
    - mode: 700
{% endif %}

