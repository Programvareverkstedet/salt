/usr/local/etc/mail/spamassassin/local.cf:
  file.managed:
    - source: salt://{{ tpldir }}/local.cf
