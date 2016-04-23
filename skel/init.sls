/bin/msgsh:
  file.managed:
    - source: salt://{{ tpldir }}/msgsh
    - mode: 555

/bin/sperret:
  file.managed:
    - source: salt://{{ tpldir }}/sperret
    - mode: 555

{% if grains['kernel'] == 'Linux' %}

/local/skel/environment:
  file.managed:
    - source: salt://{{ tpldir }}/environment@linux
{% endif %}

/local/skel/make-env.pl:
  cmd.wait:
    - watch:
      - file: /local/skel/environment
      - file: /local/skel/make-env.pl
  file.managed:
    - source: salt://{{ tpldir }}/make-env.pl
    - mode: 555

/local/skel:
  file.recurse:
    - source: salt://{{ tpldir }}/files

/local/skel/wmrcmk:
  file.recurse:
    - source: salt://{{ tpldir }}/wmrc

make_wmrc:
  cmd.wait:
    - watch:
      - file: /local/skel/wmrcmk
    - name: "umask 022 && cd /local/skel/wmrcmk && /store/gnu/bin/make"
