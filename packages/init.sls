# Package management

include:
  - packages.autoupdates

/etc/apt/sources.list.d/debian-backports.list:
{% if grains.os == 'Debian' %}
  file.managed:
    - contents: |
        deb http://ftp.debian.org/debian {{ grains.oscodename }}-backports main
        deb-src http://ftp.debian.org/debian {{ grains.oscodename }}-backports main
{% else %}
  file.absent
{% endif %}

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
