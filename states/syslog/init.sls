/etc/rsyslog.d/pvv.conf:
  file.managed:
    - source: salt://syslog/rsyslog_pvv.conf

restart_syslog:
  cmd.wait:
    - watch:
      - file: /etc/rsyslog.d/pvv.conf
    - name: "[ -x /etc/init.d/rsyslog ] && /etc/init.d/rsyslog restart"
