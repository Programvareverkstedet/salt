/etc/Muttrc:
  file.managed:
    - source: salt://mail/Muttrc

/etc/pine.conf:
  file.managed:
    - source: salt://mail/pine.conf

/etc/procmailrc:
  file.managed:
    - source: salt://mail/procmailrc

# FIXME: skal ssmtp.conf også distes?
