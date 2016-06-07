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
      - slrn
      - tin
      - screen
      - tmux
      - weechat

# See also mandatory_editor_packages in ../mandatory/init.sls
standard_editor_packages:
  pkg.installed:
    - pkgs:
      - aspell
      - aspell-en
      - aspell-no
      - vim-latexsuite

standard_misc_packages:
  pkg.installed:
    - pkgs:
      - lilypond

{% endif %}
