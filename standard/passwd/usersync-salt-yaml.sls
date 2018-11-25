{% for pvvuser in pillar['passwd']['passwd.pvv'].values() %}
pvvuser_{{ pvvuser.name }}:
  user.present:
    - name: {{ pvvuser.name }}
    - uid: {{ pvvuser.uid }}
    - gid: {{ pvvuser.gid }}
    - home: {{ pvvuser.home }}
    - fullname: {{ pvvuser.fullname|yaml_encode }}
    - shell: {{ pvvuser.shell }}
    - createhome: False
{% endfor %}

{% for pvvgroup in pillar['passwd']['group.pvv'].values() %}
pvvgroup_{{ pvvgroup.name }}:
  group.present:
    - name: {{ pvvgroup.name }}
    - gid: {{ pvvgroup.gid }}
    - members:
{% for member in pvvgroup.members %}
      - {{ member }}
{% endfor %}
{% endfor %}
