# Ting som distes til filserveren

/local/quota/quota.txt:
  file.managed:
    - contents_pillar: files:quota:quota.txt
    - mode: 400

/local/quota/makeexportsandquota.pl:
  cmd.wait:
    - watch:
      - file: /local/quota/quota.txt
  file.managed:
    - source: salt://{{ tpldir }}/makeexportsandquota.pl
    - mode: 500

/etc/init.d/pvv-quotas:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-quotas.initscript
    - mode: 500

configure_initscript:
  cmd.wait:
    - name: '/usr/sbin/update-rc.d pvv-quotas start 19 2 3 4 5 . stop 0 0 1 6 .'
    - watch:
      - file: /etc/init.d/pvv-quotas

/local/quota/userfiles.pl:
  file.managed:
    - source: salt://{{ tpldir }}/userfiles.pl
    - mode: 500

/etc/cron.daily/pvv-warnmailquota:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-warnmailquota
    - mode: 544
