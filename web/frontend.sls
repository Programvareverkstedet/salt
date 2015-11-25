/usr/local/sbin/fiks-pvv-apache.sh:
  cmd.wait:
    - watch:
      - file: /usr/local/sbin/fiks-pvv-apache.sh
      - file: /etc/apache2/sites-available/www.pvv.ntnu.no.conf
      - file: /etc/apache2/certs/www.pvv.ntnu.no.crt
      - file: /etc/apache2/certs/www.pvv.ntnu.no.key
  file.managed:
    - source: salt://web/fiks-pvv-apache-frontend.sh
    - mode: 500

/etc/apache2/sites-available/www.pvv.ntnu.no.conf:
  file.managed:
    - source: salt://web/sites-available/www.pvv.ntnu.no.frontend

# Note: used both in frontend.sls and homes.sls
/etc/apache2/certs/www.pvv.ntnu.no.crt:
  file.managed:
    - source: salt://web/certs/www.pvv.ntnu.no.crt

# Note: used both in frontend.sls and homes.sls
/etc/apache2/certs/www.pvv.ntnu.no.key:
  file.managed:
    - source: salt://web/certs/www.pvv.ntnu.no.key

# Note: used both in frontend.sls and homes.sls
/etc/apache2/certs/DigiCertCA.crt:
  file.managed:
    - source: salt://web/certs/DigiCertCA.crt
