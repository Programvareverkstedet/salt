/etc/cron.daily/postgresql-backup:
  file.managed:
    - source: salt://db/postgresql/postgresql-backup.sh
