# This will make sure that the message of the day file stays updated!
/local/etc/motd:
  file.managed:
    - source: salt://motd/motd
