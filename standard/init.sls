include:
  - .authorized_keys
  - .automount
  - .detach
  - .etc
  - .kerberos
  - .hosts
  - .mail
  - .motd
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

{% endif %}
