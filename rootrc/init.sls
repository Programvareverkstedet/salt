# denne pakken inneholder dot-filer etc. som skal til root sin
# hjemmekatalog

/root/.vimrc:
  file.managed:
    - source: salt://{{ tpldir }}/vimrc

/root/.bashrc:
  file.managed:
    - source: salt://{{ tpldir }}/bashrc

/root/.bash_logout:
  file.managed:
    - source: salt://{{ tpldir }}/bash_logout

/root/.bash_profile:
  file.managed:
    - source: salt://{{ tpldir }}/bash_profile
