# Pkgsync er et system for å holde debian/ubuntu-bokser oppdatert med et gitt
# pakkeutvalg.

include:
  - packages.autoupdates

# Ensure older debian has new enough salt-minion
/etc/apt/sources.list.d/saltstack.list:
{% if grains.has_key('oscodename') and grains['oscodename'] in ('jessie', 'wheezy', 'squeeze') and grains['osarch'] != 'ia64' and grains['osarch'] != 'powerpc' %}
  file.managed:
    - source: salt://{{ tpldir }}/sources.list.d/saltstack.list.jinja
    - template: jinja
    - context:
        oscodename: {{ grains['oscodename'] }}
{% elif grains.has_key('oscodename') and grains['oscodename'] == 'trusty' %}
  file.managed:
    - source: salt://{{ tpldir }}/sources.list.d/saltstack.list.{{ grains['oscodename'] }}
{% else %}
  file.absent
{% endif %}

/etc/apt/sources.list.d/squeeze-backports.list:
{% if grains.has_key('oscodename') and grains['oscodename'] == 'squeeze' %}
  file.managed:
    - source: salt://{{ tpldir }}/sources.list.d/squeeze-backports.list
{% else %}
  file.absent
{% endif %}

{% if grains.kernel == 'FreeBSD' }
/usr/local/etc/pkg/repos/saltstack.conf:
  file.managed:
    - source: salt://{{ tpldir }}/saltstack_freebsd.conf
    - makedirs: True
{% endif %}

{% if 'pkgsync' in grains['roles'] %}

{% if 'web-homes' in grains['roles'] %}
{% set syncdir = 'web' %}
{% else %}
{% set syncdir = 'default' %}
{% endif %}

/etc/pkgsync/musthave:
  file.managed:
    - source: salt://{{ tpldir }}/{{ syncdir }}/musthave

/etc/pkgsync/mayhave:
  file.managed:
    - source: salt://{{ tpldir }}/{{ syncdir }}/mayhave

/etc/pkgsync/maynothave:
  file.managed:
    - source: salt://{{ tpldir }}/{{ syncdir }}/maynothave

{% endif %}
