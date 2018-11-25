{% set pvv_mysql_client_config = {
    'RedHat': '/etc/my.cnf.d/pvv-client.cnf',
    'Debian': '/etc/mysql/conf.d/pvv-client.cnf',
}.get(grains.os_family) %}

{% if pvv_mysql_client_config %}
{{ pvv_mysql_client_config }}:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-client.cnf
{% endif %}
