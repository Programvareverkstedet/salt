# Depend: detach

# wtmptail er en liten demon som sjekker wtmp/wtmpx-filene for
# tilfoyelser (dvs. at noen logger inn).
# Genererer saa en syslog-melding paa et format som er lett aa parse.

{% if grains['kernel'] == 'Linux' %}

#
# binaer-filer
# (kildekoden ligger i src-katalogen)
#

/usr/local/sbin/wtmptail:
  file.managed:
    - source: salt://{{ tpldir }}/wtmptail@386linuxlibc5
    - mode: 555

#
# init-filer
#

/etc/rc.d/init.d/wtmptail:
  file.managed:
    - source: salt://{{ tpldir }}/wtmptail.init
    - mode: 555

# Trigger-kommandoer

wtmptail_restart:
  cmd.wait:
    - watch:
      - file: /usr/local/sbin/wtmptail
      - file: /etc/rc.d/init.d/wtmptail
    - name: "/etc/rc.d/init.d/wtmptail stop; /etc/rc.d/init.d/wtmptail start"

wtmptail_init_symlink:
  cmd.wait:
    - watch:
      - file: /etc/rc.d/init.d/wtmptail
    - name: "rm -f /etc/rc.d/rc?.d/???wtmptail; ln -s /etc/rc.d/init.d/wtmptail /etc/rc.d/rc3.d/S99wtmptail"

{% else %}
syntax error to alert about unsupported architecture
{% endif %}
