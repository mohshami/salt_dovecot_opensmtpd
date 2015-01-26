dkimproxy_out:
  service:
    - running
    - enable: True
    - watch:
      - file: /usr/local/etc/dkimproxy/keyfiles
      - file: /usr/local/etc/dkimproxy_out.conf

/usr/local/etc/dkimproxy:
  file.directory:
    - makedirs: True

/usr/local/etc/dkimproxy/keyfiles:
  file.managed:
    - source: salt://mailsrv/conf/dkimproxy/keyfiles
    - template: jinja
    - require:
      - file: /usr/local/etc/dkimproxy

/usr/local/etc/dkimproxy_out.conf:
  file.managed:
    - source: salt://mailsrv/conf/dkimproxy_out.conf
    - user: dkimproxy
    - group: dkimproxy
    - file_mode: 640
    - require:
      - file: /usr/local/etc/dkimproxy
