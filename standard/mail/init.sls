/etc/Muttrc:
  file.managed:
    - source: salt://{{ tpldir }}/Muttrc

/etc/pine.conf:
  file.managed:
    - source: salt://{{ tpldir }}/pine.conf

/etc/procmailrc:
  file.managed:
    - source: salt://{{ tpldir }}/procmailrc

# FIXME: skal ssmtp.conf også distes?
