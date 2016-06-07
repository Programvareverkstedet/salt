#
# X-relaterte filer
#

/etc/X11/Sessions/PVV-Session:
  file.managed:
    - source: salt://{{ tpldir }}/PVV-Session

/etc/X11/sessions/PVV-Session.desktop:
  file.managed:
    - source: salt://{{ tpldir }}/PVV-Session.desktop
