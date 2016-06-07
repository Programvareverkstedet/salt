include:
  - .autoupdates
  - .rootrc
  - .security
  - .syslog
  #- .wtmptail
  - .xntpd

mandatory_packages:
  pkg.installed:
    - pkgs:
      - emacs
      - joe
      - vim
