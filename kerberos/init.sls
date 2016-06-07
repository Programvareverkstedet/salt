/etc/krb5.conf:
  file.managed:
    - source: salt://{{ tpldir }}/krb5.conf

{% if grains.os_family is defined and grains.os_family == 'Debian' %}
kerberos_client_packages:
  pkg.installed:
    - pkgs:
      - heimdal-clients
      - libpam-krb5
{% endif %}
