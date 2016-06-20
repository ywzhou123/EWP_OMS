www-user-group:
  group.present:
    - name: www
    - gid: 1000
  user.present:
    - name: www
    - fullname: www
    - shell: /sbin/nologin
    - uid: 1000
    - gid: 1000