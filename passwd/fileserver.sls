# Passwd-relaterte ting som distes til filserveren

/usr/local/sbin/make-homes.pl:
  cmd.wait:
    - watch:
      - file: /etc/passwd.pvv
  file.managed:
    - source: salt://passwd/make-homes.pl
    - mode: 755
