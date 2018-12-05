# passwd.pvv hentes via salt.pillar.file_tree-modulen, og selve filen
# ligger i pillar/files/nodegroups/all/files/passwd.pvv

include:
  - .usersync-salt-yaml

/etc/netgroup:
  file.managed:
    - source: salt://{{ tpldir }}/netgroup

sh_packages:
  pkg.installed:
    - pkgs:
# tcsh is only included in FreeBSD
{% if grains.kernel != 'FreeBSD' %}
      - tcsh
{% endif %}
# bash is not included in FreeBSD
{% if grains.kernel == 'FreeBSD' %}
      - bash
{% endif %}
      - zsh
