#
# konfigfiler og initscripts for sshd.
#

/etc/ssh/sshd_config:
  file.managed:
{% if 'fwlogin' in grains['roles'] %}
    - source: salt://sshd/sshd_config.fwlogin
{% else %}
    - source: salt://sshd/sshd_config
{% endif %}

/etc/ssh/ssh_config:
  file.managed:
    - source: salt://sshd/ssh_config

# Distribute every keyfile we have in pillar.
# Pillar only exposes the key files which belong on this host.
{% for keyfile in pillar['files']['ssh_keys'].keys() %}
/etc/ssh/{{ keyfile }}:
  file.managed:
    - contents_pillar: files:ssh_keys:{{ keyfile }}
{% if keyfile[-4:] == '.pub' %}
    - mode: 644
{% else %}
    - mode: 600
{% endif %}
{% endfor %}
