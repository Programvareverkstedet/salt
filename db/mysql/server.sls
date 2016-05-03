/etc/cron.daily/mysql-backup:
  file.managed:
    - source: salt://{{ tpldir }}/mysql-backup.sh

/etc/mysql/conf.d/pvv.cnf:
  file.managed:
    - source: salt://{{ tpldir }}/pvv.cnf

mysql:
  service.running:
    - watch:
      - file: /etc/mysql/conf.d/pvv.cnf

mysql-server:
  pkg.installed: []
