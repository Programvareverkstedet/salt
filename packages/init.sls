# Package management

include:
  - packages.autoupdates

{% if 'pkgsync' in grains.roles %}

{% if 'web-homes' in grains.roles %}
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
