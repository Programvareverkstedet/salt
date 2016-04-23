# SSH-keys for root

/root/.ssh/authorized_keys:
  file.managed:
    - source: salt://{{ tpldir }}/authorized_keys

/root/.ssh/authorized_keys2:
  file.managed:
    - source: salt://{{ tpldir }}/authorized_keys2

