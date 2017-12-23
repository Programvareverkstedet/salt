# Package management

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

{% set syncdir = 'default' %}

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
