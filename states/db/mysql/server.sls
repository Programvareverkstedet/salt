/etc/cron.daily/mysql-backup:
  file.managed:
    - source: salt://db/mysql/mysql-backup.sh
