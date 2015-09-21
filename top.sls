#The salt top file
#For documentation please reffer to pvv.ntnu.no/pvv/Drift/Salt

base:
  '*':
    - common
  'roles:desktop':
    - match: grain
    - sltest
