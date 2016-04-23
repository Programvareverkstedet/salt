/usr/local/sbin/fiks-pvv-apache.sh:
  cmd.wait:
    - watch:
      - file: /usr/local/sbin/fiks-pvv-apache.sh
      - file: /etc/apache2/ports.conf
{% if grains['oscodename'] == 'wheezy' %}
      - file: /etc/apache2/sites-available/www.pvv.ntnu.no
{% else %}
      - file: /etc/apache2/sites-available/www.pvv.ntnu.no.conf
{% endif %}
      - file: /etc/apache2/mods-available/userdir.conf
      - file: /etc/apache2/mods-available/dir.conf
      - file: /etc/php5/conf.d/php_pvv.ini
      - file: /usr/local/sbin/apache-logger
      - file: /etc/apache2/certs/www.pvv.ntnu.no.crt
      - file: /etc/apache2/certs/www.pvv.ntnu.no.key
  file.managed:
    - source: salt://{{ tpldir }}/fiks-pvv-apache-homes.sh
    - mode: 500

/etc/apache2/ports.conf:
  file.managed:
    - source: salt://{{ tpldir }}/ports.conf

{% if grains['oscodename'] == 'wheezy' %}
/etc/apache2/sites-available/www.pvv.ntnu.no:
{% else %}
/etc/apache2/sites-available/www.pvv.ntnu.no.conf:
{% endif %}
  file.managed:
    - source: salt://{{ tpldir }}/www.pvv.ntnu.no.homes

/etc/apache2/mods-available/userdir.conf:
  file.managed:
    - source: salt://{{ tpldir }}/userdir.conf

/etc/apache2/mods-available/dir.conf:
  file.managed:
    - source: salt://{{ tpldir }}/dir.conf

/etc/php5/conf.d/php_pvv.ini:
  file.managed:
    - source: salt://{{ tpldir }}/php_pvv.ini

/usr/local/sbin/apache-logger:
  file.managed:
    - source: salt://{{ tpldir }}/apache-logger
    - mode: 555

/etc/squirrelmail/config_local.php:
  file.managed:
    - source: salt://{{ tpldir }}/config_local.php

/usr/local/bin/pvv-php-sendmail-wrapper:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-php-sendmail-wrapper

# Note: used both in frontend.sls and homes.sls
/etc/apache2/certs/www.pvv.ntnu.no.crt:
  file.managed:
    - source: salt://{{ tpldir }}/www.pvv.ntnu.no.crt

# Note: used both in frontend.sls and homes.sls
/etc/apache2/certs/www.pvv.ntnu.no.key:
  file.managed:
    - source: salt://{{ tpldir }}/www.pvv.ntnu.no.key

# Note: used both in frontend.sls and homes.sls
/etc/apache2/certs/DigiCertCA.crt:
  file.managed:
    - source: salt://{{ tpldir }}/DigiCertCA.crt
