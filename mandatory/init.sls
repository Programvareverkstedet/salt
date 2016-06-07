include:
  - .autoupdates
  - .rootrc
  - .security
  - .syslog
  #- .wtmptail
  - .ntp

mandatory_packages:
  pkg.installed:
    - pkgs:
      - emacs
      - joe
      - vim
