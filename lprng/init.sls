/etc/lpd.conf:
  file.managed:
    - source: salt://{{ tpldir }}/lpd.conf

/etc/printcap:
  file.managed:
    - source: salt://{{ tpldir }}/printcap
