/local/etc/lpd.conf:
  file.managed:
    - source: salt://lprng/lpd.conf

/local/etc/printcap:
  file.managed:
    - source: salt://lprng/printcap

/etc/lpd.conf:
  file.managed:
    - source: salt://lprng/lpd.conf

/etc/printcap:
  file.managed:
    - source: salt://lprng/printcap
