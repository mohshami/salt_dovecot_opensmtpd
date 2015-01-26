dovecot:
  service:
    - running
    - reload: True
    - watch:
      - file: /usr/local/etc/dovecot/dovecot-passwd
      - file: /usr/local/etc/dovecot/dovecot.conf

/usr/local/etc/dovecot:
  file.directory:
    - makedirs: True

/usr/local/etc/dovecot/dovecot-passwd:
  file.managed:
    - source: salt://mailsrv/conf/dovecot/dovecot-passwd
    - template: jinja
    - require:
      - file: /usr/local/etc/dovecot

/usr/local/etc/dovecot/dovecot.conf:
  file.managed:
    - source: salt://mailsrv/conf/dovecot/dovecot.conf
    - require:
      - file: /usr/local/etc/dovecot
