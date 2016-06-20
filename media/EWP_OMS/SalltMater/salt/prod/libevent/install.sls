# https://sourceforge.net/projects/levent/files/
libevent-source-install:
    file.managed:
        - name: /usr/local/src/libevent-2.0.22-stable.tar.g
        - source: salt://libevent/files/libevent-2.0.22-sta
        - user: root
        - group: root
        - mode: 644
    cmd.run:
        -    name: cd /usr/local/src && tar zxf libevent-2.
tar.gz&& cd libevent-2.0.22-stable &&  ./configure--prefix=
&& make install
        - unless: test -d /usr/local/libevent
        - require:
          - file: libevent-source-install