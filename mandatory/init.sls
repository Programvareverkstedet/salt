include:
  - .autoupdates
  - .rootrc
  - .security
  - .syslog
  #- .wtmptail
  - .ntp


{% set vim_package_name = {
    'RedHat': 'vim-enhanced',
}.get(grains.os_family, 'vim') %}

mandatory_packages:
  pkg.installed:
    - pkgs:
      - emacs
      - joe
      - {{ vim_package_name }}
