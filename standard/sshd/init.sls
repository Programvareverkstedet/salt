#
# konfigfiler og initscripts for sshd.
#

{% set sshd_service = {
    'Debian': 'ssh',
    'FreeBSD': 'sshd',
}.get(grains.os_family) %}

{% set sftp_path = {
    'Debian': '/usr/lib/sftp-server',
    'FreeBSD': '/usr/libexec/sftp-server',
}.get(grains.os_family) %}


/etc/ssh/sshd_config:
  file.managed:
    - source: salt://{{ tpldir }}/sshd_config.jinja
    - template: jinja
    - context:
      sftp_path: {{ sftp_path }}
{% if 'fwlogin' in grains['roles'] %}
      ports: [22, 80, 443]
{% else %}
      ports: [22]
{% endif %}

/etc/ssh/ssh_config:
  file.managed:
    - source: salt://{{ tpldir }}/ssh_config

# Distribute every keyfile we have in pillar.
# Pillar only exposes the key files which belong on this host.
# Notice the contents_newline, which is necessary because ssh_host_key (the
# dsa1 key) is binary.
{% for keyfile in pillar['files']['ssh_keys'].keys() %}
/etc/ssh/{{ keyfile }}:
  file.managed:
    - contents_pillar: files:ssh_keys:{{ keyfile }}
    - contents_newline: False
{% if keyfile[-4:] == '.pub' %}
    - mode: 644
{% else %}
    - mode: 600
{% endif %}
{% endfor %}

sshd-service:
  service.running:
    - name: {{ sshd_service }}
    - watch:
      - file: /etc/ssh/sshd_config
