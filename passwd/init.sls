/etc/passwd.pvv:
  file.managed:
    - source: salt://passwd/passwd.pvv.nohash

/usr/local/sbin/merge-passwd.pl:
  cmd.wait:
    - watch:
      - file: /etc/passwd.pvv
  file.managed:
    - source: salt://passwd/merge-passwd.pl

/etc/group.pvv:
  file.managed:
    - source: salt://passwd/group.pvv

/usr/local/sbin/merge-group.pl:
  cmd.wait:
    - watch:
      - file: /etc/group.pvv
  file.managed:
    - source: salt://passwd/merge-group.pl

/etc/netgroup:
  file.managed:
    - source: salt://passwd/netgroup
