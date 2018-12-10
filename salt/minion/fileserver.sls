
# Make salt-install.sh available from https://www.pvv.ntnu.no/salt/salt-setup.sh for bootstrapping
/home/pvv/c/pvv/web-root/salt/saltstack-build.sh:
  file.managed:
    - source: salt://{{ tpldir }}/saltstack-build.cron
    - makedirs: True

/home/pvv/c/pvv/web-root/salt/salt-setup.sh:
  file.managed:
    - source: salt://{{ tpldir }}/salt-setup.sh
    - makedirs: True

