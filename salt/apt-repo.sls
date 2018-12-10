
{% set osdir = {
    'Ubuntu': grains.osrelease,
    'Debian': grains.osmajorrelease,
}.get(grains.os) %}
{% set apt_url = 'repo.saltstack.com/apt/%s/%s/amd64/latest'|format(grains.os|lower, osdir) %}

saltstack-pkgrepo:
  pkgrepo.managed:
    - humanname: SaltStack repo
    - name: deb http://{{ apt_url }} {{ grains.oscodename }} main
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: https://{{ apt_url }}/SALTSTACK-GPG-KEY.pub
{% if grains.os == "Ubuntu" %} # The ubuntu-repo has only amd64
    - architectures: amd64     # unlike the debian-repo which has both amd64 and i386
{% endif %}

