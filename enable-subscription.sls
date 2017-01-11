{% set rhel_subscription_server = "satserver" %}

{% set ose_version = "3.3" %}

"Satellite preparation":
      cmd.run:
        - name: rpm -Uvh http://{{ rhel_subscription_server }}/pub/katello-ca-consumer-latest.noarch.rpm
        - creates: /etc/rhsm/ca/katello-server-ca.pem

"Disable all repositories":
  cmd.run:
    - name:  subscription-manager repos --disable="*"
    - require:
      - cmd: "Satellite preparation"


"Enable RHEL repositories":
  cmd.run:
    - name: |
        subscription-manager repos \
        --enable="rhel-7-server-rpms" \
        --enable="rhel-7-server-extras-rpms" \
        --enable="rhel-7-server-ose-{{ ose_version }}-rpms""

"Refresh repositories":
  cmd.run:
    - name:  subscription-manager refresh

"Status repositories":
  cmd.run:
    - name:  subscription-manager status


{#
subscription-manager list --available --matches="{{ rhel_subscription_pool }}" --pool-only
subscription-manager list --consumed --matches="{{ rhel_subscription_pool }}" --pool-only
#}
