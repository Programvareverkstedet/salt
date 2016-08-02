/etc/mysql/conf.d/pvv-client.cnf:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-client.cnf
