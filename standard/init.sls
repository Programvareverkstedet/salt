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

standard_mailirc_packages:
  pkg.installed:
    - pkgs:
      - alpine
      - ircii
      - irssi
      - irssi-scripts
      - irssi-plugin-xmpp
      - links
      - lynx
      - maildrop
      - mailutils
      - mutt
      - ncftp
      - oidentd
      - screen
      - slrn
      - tin
      - tmux
      - weechat

standard_editor_packages:
  pkg.installed:
    - pkgs:
      - emacs
      - aspell
      - aspell-en
      - aspell-no
      - joe
      - vim
      - vim-latexsuite

standard_misc_packages:
  pkg.installed:
    - pkgs:
      - lilypond

{% endif %}
