# SSH-keys for root

/root/.ssh:
  file.directory:
    - user: root
    - group: root
    - mode: 700

/root/.ssh/authorized_keys:
  file.managed:
    - source: salt://{{ tpldir }}/authorized_keys
    - require:
      - file: /root/.ssh

/root/.ssh/authorized_keys2:
  file.managed:
    - source: salt://{{ tpldir }}/authorized_keys2
    - require:
      - file: /root/.ssh

