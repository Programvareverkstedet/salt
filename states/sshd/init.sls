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
