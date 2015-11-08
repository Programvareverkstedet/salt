/bin/msgsh:
  file.managed:
    - source: salt://skel/msgsh
    - mode: 555

/bin/sperret:
  file.managed:
    - source: salt://skel/sperret
    - mode: 555

{% if grains['kernel'] == 'Linux' %}

/local/skel/environment:
  file.managed:
    - source: salt://skel/env/environment@linux
{% else %}
syntax error to alert about unsupported architecture
{% endif %}

/local/skel/make-env.pl:
  cmd.wait:
    - watch:
      - file: /local/skel/environment
      - file: /local/skel/make-env.pl
  file.managed:
    - source: salt://skel/env/make-env.pl
    - mode: 555

/local/skel:
  file.recurse:
    - source: salt://skel/files

/local/skel/wmrcmk:
  file.recurse:
    - source: salt://skel/wmrc

make_wmrc:
  cmd.wait:
    - watch:
      - file: /local/skel/wmrcmk
    - name: "umask 022 && cd /local/skel/wmrcmk && /store/gnu/bin/make"
