# Pkgsync er et system for å holde debian/ubuntu-bokser oppdatert med et gitt
# pakkeutvalg.

include:
  - packages.autoupdates

# Ensure older debian has new enough salt-minion
/etc/apt/sources.list.d/saltstack.list:
{% if grains['oscodename'] in ('jessie', 'wheezy', 'squeeze') and grains['osarch'] != 'ia64' %}
  file.managed:
    - source: salt://packages/sources.list.d/saltstack.list.jinja
    - template: jinja
    - context:
        oscodename: {{ grains['oscodename'] }}
{% elif grains['oscodename'] == 'trusty' %}
  file.managed:
    - source: salt://packages/sources.list.d/saltstack.list.{{ grains['oscodename'] }}
{% else %}
  file.absent
{% endif %}

/etc/apt/sources.list.d/squeeze-backports.list:
{% if grains['oscodename'] == 'squeeze' %}
  file.managed:
    - source: salt://packages/sources.list.d/squeeze-backports.list
{% else %}
  file.absent
{% endif %}

{% if 'pkgsync' in grains['roles'] %}

{% if 'web-homes' in grains['roles'] %}
{% set syncdir = 'web' %}
{% else %}
{% set syncdir = 'default' %}
{% endif %}

/etc/pkgsync/musthave:
  file.managed:
    - source: salt://packages/{{ syncdir }}/musthave

/etc/pkgsync/mayhave:
  file.managed:
    - source: salt://packages/{{ syncdir }}/mayhave

/etc/pkgsync/maynothave:
  file.managed:
    - source: salt://packages/{{ syncdir }}/maynothave

{% endif %}
