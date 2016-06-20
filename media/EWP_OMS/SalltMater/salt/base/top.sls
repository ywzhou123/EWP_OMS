base:
  '*':
    - init.env_init
prod:
  '*':
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
    - web.bbs
  'saltstack-node2.example.com':
    - memcached.service