include:
  - .certs

/usr/local/sbin/fiks-pvv-apache.sh:
  cmd.wait:
    - watch:
      - file: /usr/local/sbin/fiks-pvv-apache.sh
{% if grains['oscodename'] == 'wheezy' %}
      - file: /etc/apache2/sites-available/www.pvv.ntnu.no
{% else %}
      - file: /etc/apache2/sites-available/www.pvv.ntnu.no.conf
{% endif %}
      - file: /etc/apache2/mods-available/userdir.conf
      - file: /etc/apache2/mods-available/dir.conf
      - file: /etc/php/7.0/apache2/conf.d/pvv.ini
      - file: /usr/local/sbin/apache-logger
      - file: /etc/apache2/certs/www.pvv.ntnu.no.crt
      - file: /etc/apache2/certs/www.pvv.ntnu.no.key
  file.managed:
    - source: salt://{{ tpldir }}/fiks-pvv-apache-homes.sh
    - mode: 500

{% if grains['oscodename'] == 'wheezy' %}
/etc/apache2/sites-available/www.pvv.ntnu.no:
{% else %}
/etc/apache2/sites-available/www.pvv.ntnu.no.conf:
{% endif %}
  file.managed:
    - source: salt://{{ tpldir }}/sites-available/www.pvv.ntnu.no.homes

/etc/apache2/mods-available/userdir.conf:
  file.managed:
    - source: salt://{{ tpldir }}/mods-available/userdir.conf

/etc/apache2/mods-available/dir.conf:
  file.managed:
    - source: salt://{{ tpldir }}/mods-available/dir.conf

/etc/php/7.0/apache2/conf.d/php_pvv.ini:
  file.managed:
    - source: salt://{{ tpldir }}/php_pvv.ini

/usr/local/sbin/apache-logger:
  file.managed:
    - source: salt://{{ tpldir }}/apache-logger
    - mode: 555

/usr/local/bin/pvv-php-sendmail-wrapper:
  file.managed:
    - source: salt://{{ tpldir }}/pvv-php-sendmail-wrapper
