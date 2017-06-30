
prevent empty rendering:
  test.nop:
    - name: skip

{% for host in salt.saltutil.runner('select.minions', cluster='ceph', roles='mgr', host=True) %}
{% set client = "mgr." + host %}
{% set keyring_file = salt['keyring.file']('mgr', host)  %}

auth {{ keyring_file }}:
  cmd.run:
    - name: "ceph auth get {{ client }} >/dev/null 2>&1 && ceph auth del {{ client }} >/dev/null 2>&1 ; ceph auth add {{ client }} -i {{ keyring_file }}"

{% endfor %}


