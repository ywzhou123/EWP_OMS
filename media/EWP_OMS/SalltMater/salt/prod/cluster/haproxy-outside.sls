include:
  - haproxy.install
haproxy-service:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://haproxy/files/haproxy.cfg
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - cmd: haproxy-init
    - watch:
      - file: haproxy-service