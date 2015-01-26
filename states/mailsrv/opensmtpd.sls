smtpd:
  service:
    - running
    - watch:
      - file: /usr/local/etc/mail/vdomains
      - file: /usr/local/etc/mail/recipients
      - file: /usr/local/etc/mail/passwd
      - file: /usr/local/etc/mail/smtpd.conf
      - file: /usr/local/etc/mail/cert

/usr/local/etc/mail:
  file.directory:
    - makedirs: True

/usr/local/etc/mail/vdomains:
  file.managed:
    - source: salt://mailsrv/conf/opensmtpd/vdomains
    - template: jinja
    - require:
      - file: /usr/local/etc/mail

/usr/local/etc/mail/recipients:
  file.managed:
    - source: salt://mailsrv/conf/opensmtpd/recipients
    - template: jinja
    - require:
      - file: /usr/local/etc/mail

/usr/local/etc/mail/passwd:
  file.managed:
    - source: salt://mailsrv/conf/opensmtpd/passwd
    - template: jinja
    - require:
      - file: /usr/local/etc/mail

/usr/local/etc/mail/smtpd.conf:
  file.managed:
    - source: salt://mailsrv/conf/opensmtpd/smtpd.conf
    - require:
      - file: /usr/local/etc/mail

/usr/local/etc/mail/cert:
  file.recurse:
    - source: salt://mailsrv/conf/opensmtpd/cert
    - user: root
    - group: wheel
    - file_mode: 600
    - dir_mode: 700
    - require:
      - file: /usr/local/etc/mail
