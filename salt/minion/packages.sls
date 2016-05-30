{% set use_saltstack_apt = grains.os_family is defined and grains.os_family == 'Debian' %}

{% if use_saltstack_apt %}
{% if grains.oscodename == 'wily' %}
{% set osdir = '14.04' %}
{% set oscodename = 'trusty' %}
{% else %}
{% set osdir = {
    'Ubuntu': grains.osrelease,
    'Debian': grains.osmajorrelease,
}.get(grains.os) %}
{% set oscodename = grains.oscodename %}
{% endif %}
{% set saltstack_apt_url = 'repo.saltstack.com/apt/' ~ grains.os | lower ~ '/' ~ osdir ~ '/amd64/latest' %}
{% endif %}

/etc/apt/sources.list.d/saltstack.list:
{% if use_saltstack_apt %}
  file.managed:
    - contents: |
{% if grains.osarch == 'amd64' %}
        deb http://{{ saltstack_apt_url }} {{ oscodename }} main
{% endif %}
        deb-src http://{{ saltstack_apt_url }} {{ oscodename }} main
{% else %}
  file.absent
{% endif %}

{% if use_saltstack_apt %}
install_saltstack_apt_key:
  cmd.wait:
    - name: wget -O - https://{{ saltstack_apt_url }}/SALTSTACK-GPG-KEY.pub | apt-key add -
    - watch:
      - file: /etc/apt/sources.list.d/saltstack.list
{% endif %}

# Make non-amd64 servers build their packages based on source debs
/etc/cron.daily/saltstack-build:
{% if use_saltstack_apt and grains.osarch != 'amd64' %}
  file.managed:
    - source: salt://{{ tpldir }}/saltstack-build.cron
    - mode: 755
{% else %}
  file.absent
{% endif %}

# Make salt-install.sh available from https://www.pvv.ntnu.no/salt/salt-setup.sh for bootstrapping
{% if 'file-server' in grains.roles %}
/home/pvv/c/pvv/web-root/salt/saltstack-build.sh:
  file.managed:
    - source: salt://{{ tpldir }}/saltstack-build.cron
    - makedirs: True

/home/pvv/c/pvv/web-root/salt/salt-setup.sh:
  file.managed:
    - source: salt://{{ tpldir }}/salt-setup.sh
    - makedirs: True
{% endif %}

{% if grains.kernel == 'FreeBSD' %}
/usr/local/etc/pkg/repos/saltstack.conf:
  file.managed:
    - source: salt://{{ tpldir }}/saltstack_freebsd.conf
    - makedirs: True
{% endif %}
