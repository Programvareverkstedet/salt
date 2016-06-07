/etc/shells:
  file.managed:
    - source: salt://{{ tpldir }}/shells

/etc/resolv.conf:
  file.managed:
    - source: salt://{{ tpldir }}/resolv.conf
