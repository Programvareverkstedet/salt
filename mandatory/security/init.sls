{% if grains['kernel'] == 'Linux' %}

/etc/security/limits.conf:
  file.managed:
    - source: salt://{{ tpldir }}/limits.conf

{% endif %}
