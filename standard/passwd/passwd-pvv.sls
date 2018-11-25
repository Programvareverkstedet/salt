
/etc/passwd.pvv:
  file.managed:
    - contents_pillar: files:passwd:passwd.pvv
