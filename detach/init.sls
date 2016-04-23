{% if grains['kernel'] == 'Linux' %}

/usr/local/man/man1/detach.1:
  file.managed:
    - source: salt://{{ tpldir }}/detach.1

/usr/local/bin/detach:
  file.managed:
    - source: salt://{{ tpldir }}/detach@linuxelf

{% endif %}
