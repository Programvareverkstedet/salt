/etc/apache2/certs/www.pvv.ntnu.no.crt:
  file.managed:
    - source: salt://{{ tpldir }}/www.pvv.ntnu.no.crt

/etc/apache2/certs/www.pvv.ntnu.no.key:
  file.managed:
    - source: salt://{{ tpldir }}/www.pvv.ntnu.no.key

/etc/apache2/certs/DigiCertCA.crt:
  file.managed:
    - source: salt://{{ tpldir }}/DigiCertCA.crt
