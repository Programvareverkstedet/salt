/etc/cron.daily/postgresql-backup:
  file.managed:
    - source: salt://{{ tpldir }}/postgresql-backup.sh
