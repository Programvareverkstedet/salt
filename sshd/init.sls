#
# konfigfiler og initscripts for sshd.
#

/etc/ssh/sshd_config:
  file.managed:
{% if 'fwlogin' in grains['roles'] %}
    - source: salt://{{ tpldir }}/sshd_config.fwlogin
{% else %}
    - source: salt://{{ tpldir }}/sshd_config
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
