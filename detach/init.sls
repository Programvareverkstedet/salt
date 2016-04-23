{% if grains['kernel'] == 'Linux' %}

/usr/local/man/man1/detach.1:
  file.managed:
    - source: salt://{{ tpldir }}/ver-1.1/man/man1/detach.1

/usr/local/bin/detach:
  file.managed:
    - source: salt://{{ tpldir }}/ver-1.1/bin/detach@linuxelf

{% endif %}
