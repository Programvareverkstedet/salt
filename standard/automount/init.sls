{% set automount_service = {
    'Linux': 'autofs',
    'FreeBSD': 'automount',
}.get(grains.kernel) %}

{% set automount_file = {
    'autofs': '/etc/auto.master',
    'automount': '/etc/auto_master',
}.get(automount_service) %}

/etc:
  file.recurse:
    - source: salt://{{ tpldir }}/etc

{{ automount_file }}:
  file.managed:
    - source: salt://{{ tpldir }}/auto.master

{{ automount_service }}:
  service.running:
    - watch:
      - file: {{ automount_file }}

{% if grains['kernel'] == 'Linux' %}
nfs.packages:
  pkg.installed:
  - pkgs:
    - nfs-common
    - autofs
{% endif %}
