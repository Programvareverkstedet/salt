{% if grains['kernel'] == 'Linux' %}

/etc/security/limits.conf:
  file.managed:
    - source: salt://security/limits.conf

{% endif %}
