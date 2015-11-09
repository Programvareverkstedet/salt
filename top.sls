# Bruk {{ saltenv }} istedenfor base:, slik at konfigen under gjelder uansett hva man
# setter saltenv til. Dette lar oss bruke samme innhold i filen uansett environment.
# Merk: Dette virker bare om salt er på versjon 2015.5.3 (Lithium) og nyere, så om du trenger
#       å teste på eldre salt må du hardkode brukernavnet ditt nedenfor.
{{ env }}:
  '*':
    - salt.minion

  # Konfig som skal til alle unntatt lommel, som er salt-master
  'roles:standard':
    - match: grain
    - automount
    - cups
    - detach
    - etc
    - hosts
    - lprng
    - mail
    - motd
    - passwd
    - packages
    - quota
    - rootrc
    - rootrc.authorized_keys
    - sane
    - security
    - skel
    - sshd
    - ssl
    - syslog
    #- wtmptail
    - xntpd

  # Salt-master er ikke medlem av roles:standard
  'roles:salt-master':
    - match: grain
    - packages.autoupdates
    - salt.master
    - security
    - rootrc
    - syslog
    #- wtmptail
    - xntpd

  'roles:file-server':
    - match: grain
    - quota.fileserver
    - spamassassin

  'roles:mysql-server':
    - match: grain
    - db.mysql.server

  'roles:postgresql-server':
    - match: grain
    - db.postgresql.server

  'roles:web-frontend':
    - match: grain
    - web.frontend

  'roles:web-homes':
    - match: grain
    - web.homes

  'roles:desktop':
    - match: grain
    - X11
