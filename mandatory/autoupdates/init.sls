
{% if grains.os_family == "Debian" %}
{{ pillar.cron_daily }}/pvvpakke:
  file.managed:
    - source: salt://{{ tpldir }}/pvvpakke.sh
    - mode: 700
{% endif %}
