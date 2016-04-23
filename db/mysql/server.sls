/etc/cron.daily/mysql-backup:
  file.managed:
    - source: salt://{{ tpldir }}/mysql-backup.sh
