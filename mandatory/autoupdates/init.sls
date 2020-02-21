
{% if grains.os_family == "Debian" or grains.os_family == "FreeBSD" %}
{{ pillar.cron_daily }}/pvvpakke:
  file.managed:
    - source: salt://{{ tpldir }}/pvvpakke.sh
    - mode: 755
{% endif %}
