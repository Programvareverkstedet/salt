#
# X-relaterte filer
#

/etc/X11/Sessions/PVV-Session:
  file.managed:
    - source: salt://X11/PVV-Session

/etc/X11/sessions/PVV-Session.desktop:
  file.managed:
    - source: salt://X11/PVV-Session.desktop
