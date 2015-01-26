{% for domain in salt['pillar.get']('domains') %}

{% set keys = salt['dkim.generate']() %}

{# Only generate keys for domains with missing files #}
{% if 1 == salt['cmd.retcode']('test -f /usr/local/etc/dkimproxy/' ~ domain ~ '/private') %}

/usr/local/etc/dkimproxy/{{ domain }}:
  file.directory:
    - makedirs: True

/usr/local/etc/dkimproxy/{{ domain }}/private:
  file.managed:
    - source: salt://mailsrv/conf/dkimproxy/domain/private
    - template: jinja
    - require:
      - file: /usr/local/etc/dkimproxy/{{ domain }}
    - context:
      keys: {{ keys }}
    - watch_in:
      - service: dkimproxy_out

/usr/local/etc/dkimproxy/{{ domain }}/public:
  file.managed:
    - source: salt://mailsrv/conf/dkimproxy/domain/public
    - template: jinja
    - require:
      - file: /usr/local/etc/dkimproxy/{{ domain }}
    - context:
      keys: {{ keys }}
      domain: {{ domain }}
    - require:
      - file: /usr/local/etc/dkimproxy/{{ domain }}/private

{% endif %}
{% endfor %}
