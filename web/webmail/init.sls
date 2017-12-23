/etc/squirrelmail/config_local.php:
  file.managed:
    - source: salt://{{ tpldir }}/webmail/config_local.php
