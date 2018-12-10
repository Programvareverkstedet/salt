
include:
  - .minion
{% if grains.os_family is defined and grains.os_family == 'Debian' %}
  - .apt-repo
{% endif %}
