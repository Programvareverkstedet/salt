{% if grains.os_family is defined and grains.os_family == 'Debian' %}

fwlogin_packages:
  pkg.installed:
    - pkgs:
      - lilypond

{% endif %}
