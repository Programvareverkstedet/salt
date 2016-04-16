{% set ssl_cert_directory = {
    'Linux': '/etc/ssl/certs',
    'FreeBSD': '/etc/mail/certs',
}.get(grains.kernel) %}

{% set ssl_rehash_command = {
    'Linux': 'c_rehash',
    'FreeBSD': "sh -c 'cd /etc/mail/certs && for f in pvv-*.pem; do ln -s $f `openssl x509 -hash -noout -in $f`.0; done'",
}.get(grains.kernel) %}

{{ ssl_cert_directory }}/pvv-ca.pem:
  file.managed:
    - source: salt://ssl/pvv-ca.pem

install_ca:
  cmd.wait:
    - watch:
      - file: {{ ssl_cert_directory }}/pvv-ca.pem
    - name: {{ ssl_rehash_command }}
