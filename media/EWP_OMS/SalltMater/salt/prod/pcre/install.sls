pcre-source-install:
    file.managed:
        - name: /usr/local/src/pcre-8.37.tar.gz
        - source: salt://pcre/files/pcre-8.37.tar.gz
        - user: root
        - group: root
        - mode: 755
    cmd.run:
        - name: cd /usr/local/src && tar zxf pcre-8.37.
        - unless: test -d /usr/local/pcre
        - require:
          - file: pcre-source-install