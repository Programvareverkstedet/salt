/etc/ssl/certs/pvv-ca.pem:
  file.managed:
    - source: salt://ssl/pvv-ca.pem

install_ca:
  cmd.wait:
    - watch:
      - file: /etc/ssl/certs/pvv-ca.pem
    - name: 'c_rehash'
