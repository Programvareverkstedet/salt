# Perl-basert brukersynkronisering, raskere enn usersync-salt.sls, men ikke
# kryssplattform. 

/etc/passwd.pvv:
  file.managed:
    - contents_pillar: files:passwd:passwd.pvv

/usr/local/sbin/merge-passwd.pl:
  cmd.wait:
    - name: /usr/local/sbin/merge-passwd.pl {{ pillar['passwd']['min_uid'] }}
    - watch:
      - file: /etc/passwd.pvv
      - file: /usr/local/sbin/merge-passwd.pl
  file.managed:
    - source: salt://{{ tpldir }}/merge-passwd.pl
    - mode: 755

/etc/group.pvv:
  file.managed:
    - contents_pillar: files:passwd:group.pvv

/usr/local/sbin/merge-group.pl:
  cmd.wait:
    - name: /usr/local/sbin/merge-group.pl {{ pillar['passwd']['min_gid'] }}
    - watch:
      - file: /etc/group.pvv
      - file: /usr/local/sbin/merge-group.pl
  file.managed:
    - source: salt://{{ tpldir }}/merge-group.pl

