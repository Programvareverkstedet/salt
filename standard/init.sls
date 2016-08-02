include:
  - .authorized_keys
  - .automount
  - .detach
  - .etc
  - .kerberos
  - .hosts
  - .mail
  - .motd
  - .mysql-client
  - .passwd
  - .packages
  - .quota
  - .sane
  - .skel
  - .sshd
  - .ssl
  - .print

{% if grains.os_family is defined and grains.os_family == 'Debian' %}

# See also mandatory_packages in ../mandatory/init.sls
standard_packages:
  pkg.installed:
    - pkgs:
      # IRC clients
      - ircii
      - irssi
      - irssi-scripts
      - irssi-plugin-xmpp
      - oidentd
      - weechat
      # Text-mode mail/news clients/software
      - alpine
      - maildrop
      - mailutils
      - mutt
      - slrn
      - tin
      # Text-mode browsers/FTP clients
      - links
      - lynx
      - ncftp
      # Screen and friends
      - screen
      - tmux
      # Editors and spellchecking
      - aspell
      - aspell-en
      - aspell-no
      - vim-latexsuite
      # Revision control
      - bzr
      - cvs
      - git
      - git-arch
      - git-cvs
      - git-doc
      - git-email
      - git-svn
      - hgsubversion
      - mercurial
      - mercurial-git
      - rcs
      - subversion
      # DBMS
      - mysql-client
      - postgresql-client
      - sqlite3
      # Software development
      - autoconf
      - automake
      - autotools-dev
      - cpp
      - distcc
      - g++
      - gawk
      - gcc
      - indent
      - perl-doc
      - ruby
      # Misc toys/games
      - figlet
      - fortune
{% if grains.osarch != 'ia64' %}
      - valgrind
{% endif %}

{% endif %}
