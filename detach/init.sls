{% if grains['kernel'] == 'Linux' %}

/usr/local/man/man1/detach.1:
  file.managed:
    - source: salt://{{ tpldir }}/ver-1.1/man/man1/detach.1
    - makedirs: True

/usr/local/bin/detach:
  file.managed:
    - source: salt://{{ tpldir }}/ver-1.1/bin/detach@linuxelf
    - makedirs: True

{% endif %}
