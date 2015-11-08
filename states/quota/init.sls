# Kvoterelaterte ting som distes til "alle"

/usr/local/bin/uquota:
  file.managed:
    - source: salt://quota/uquota
    - mode: 555

{% if grains['os'] == 'Debian' %}
# Kreves av uquota
libquota-perl:
  pkg.installed
{% endif %}
