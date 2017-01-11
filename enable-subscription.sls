"Disable all repositories":
  cmd.run:
    - name:  subscription-manager repos --disable="*"

"Enable RHEL repositories":
  cmd.run:
    - name: |
        subscription-manager repos \
        --enable="rhel-7-server-rpms" \
        --enable="rhel-7-server-extras-rpms" \
        --enable="rhel-7-server-ose-{{ ose_version }}-rpms""

"Refresh repositories":
  cmd.run:
    - name:  subscription-manager repos --disable="*"
