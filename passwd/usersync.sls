#!py

# Synchronizes the users on the system with passwd.pvv and group.pvv from pillar.

import sys
import pwd
import grp

''' Ensure the user is present '''
def user_present(pw_info):
    pw_info['createhome'] = False
    if __grains__['kernel'] == 'FreeBSD' and pw_info['shell'] == '/bin/bash':
        pw_info['shell'] = '/usr/local/bin/bash'
    return ( "user_" + pw_info["name"], { 'user.present': [ { a: b } for (a, b) in pw_info.iteritems() ] } )

''' Ensure the user is absent '''
def user_absent(user):
    return ( "user_" + user, { 'user.absent': [ { 'name': user, 'purge': False } ] } )

''' Ensure the group is present '''
def group_present(group_info):
    return ( "group_" + group_info["name"], { 'group.present': [ { a: b } for (a, b) in group_info.iteritems() ] } )

''' Ensure the group is absent '''
def group_absent(group):
    return ( "group_" + group, { 'group.absent': [ { 'name': group } ] } )

def run():
    min_uid = __pillar__['passwd']['min_uid']
    min_gid = __pillar__['passwd']['min_gid']
    passwd = __pillar__['passwd']['passwd.pvv']
    group = __pillar__['passwd']['group.pvv']
    values = []
    values += [ user_present(pw_info) for pw_info in passwd.values() ]
    values += [ user_absent(u.pw_name) for u in pwd.getpwall() if u.pw_uid >= 1000 and not passwd.has_key(u.pw_name) ]
    values += [ group_present(group_info) for group_info in group.values() ]
    values += [ group_absent(u.gr_name) for u in grp.getgrall() if u.gr_gid >= 200 and not group.has_key(u.gr_name) ]
    return dict(values)
