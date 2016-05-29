{% set salt_config_dir = {
    'Linux': '/etc/salt',
    'FreeBSD': '/usr/local/etc/salt',
}.get(grains.kernel) %}

{% set salt_minion_service = {
    'Linux': 'salt-minion',
    'FreeBSD': 'salt_minion',
}.get(grains.kernel) %}

# Was renamed to pvv.conf
{{ salt_config_dir }}/minion.d/environment.conf:
  file.absent

{{ salt_config_dir }}/minion.d/pvv.conf:
  file.managed:
    - source: salt://{{ tpldir }}/minion.d/pvv.conf

{{ salt_minion_service }}:
  service.running:
    - watch:
      - file: {{ salt_config_dir }}/minion.d/environment.conf

{{ pillar.cron_daily }}/pvv-salt:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-salt.cron
    - mode: 755

{% set use_saltstack_apt = grains.os_family is defined and grains.os_family == 'Debian' and grains.oscodename != 'wily' %}

{% if use_saltstack_apt %}
{% set osdir = {
    'Ubuntu': grains.osrelease,
    'Debian': grains.osmajorrelease,
}.get(grains.os) %}
{% set saltstack_apt_url = 'repo.saltstack.com/apt/' ~ grains.os | lower ~ '/' ~ osdir ~ '/amd64/latest' %}
{% endif %}

/etc/apt/sources.list.d/saltstack.list:
{% if use_saltstack_apt %}
  file.managed:
    - contents: |
{% if grains.osarch == 'amd64' %}
        deb http://{{ saltstack_apt_url }} {{ grains.oscodename }} main
{% endif %}
        deb-src http://{{ saltstack_apt_url }} {{ grains.oscodename }} main
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

/etc/cron.daily/saltstack-build:
{% if use_saltstack_apt and grains.osarch != 'amd64' %}
  file.managed:
    - source: salt://{{ tpldir }}/saltstack-build.cron
    - mode: 755
{% else %}
  file.absent
{% endif %}

/etc/apt/sources.list.d/debian-backports.list:
{% if grains.os == 'Debian' %}
  file.managed:
    - contents: deb http://ftp.debian.org/debian {{ grains.oscodename }}-backports main
{% else %}
  file.absent
{% endif %}

{% if grains.kernel == 'FreeBSD' %}
/usr/local/etc/pkg/repos/saltstack.conf:
  file.managed:
    - source: salt://{{ tpldir }}/saltstack_freebsd.conf
    - makedirs: True
{% endif %}
