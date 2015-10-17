# denne pakken inneholder dot-filer etc. som skal til root sin
# hjemmekatalog

/root/.vimrc:
  file.managed:
    - source: salt://rootrc/vimrc

/root/.bashrc:
  file.managed:
    - source: salt://rootrc/bashrc

/root/.bash_logout:
  file.managed:
    - source: salt://rootrc/bash_logout

/root/.bash_profile:
  file.managed:
    - source: salt://rootrc/bash_profile
