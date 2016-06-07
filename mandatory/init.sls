include:
  - .autoupdates
  - .rootrc
  - .security
  - .syslog
  #- .wtmptail
  - .xntpd

mandatory_editor_packages:
  pkg.installed:
    - pkgs:
      - emacs
      - joe
      - vim
