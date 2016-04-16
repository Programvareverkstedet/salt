{% set automount_service = {
    'Linux': 'autofs',
    'FreeBSD': 'automount',
}.get(grains.kernel) %}

/etc:
  file.recurse:
    - source: salt://automount/etc

/etc/auto.master:
  file.managed:
    - source: salt://automount/auto.master

# FIXME: Just dist the file to the correct place on each OS
/etc/auto_master:
  file.symlink:
    - target: /etc/auto.master

{{ automount_service }}:
  service.running:
    - watch:
      - file: /etc/auto.master

{% if grains['kernel'] == 'Linux' %}
nfs.packages:
  pkg.installed:
  - pkgs:
    - nfs-common
    - autofs
{% endif %}
