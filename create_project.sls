{% set oc_cli = '/usr/local/bin/oc' %}
{% set runuser = 'guo' %}


{% set project_name = 'hello-openshift' %}

"create project":
  cmd.run:
   - runas: {{ runuser }}
   - onlyif: {{ oc_cli }} --config=$HOME/.kube/config  get project {{ project_name }} || echo 0
   - name: |
       cat <<EOF | {{ oc_cli }} --config=$HOME/.kube/config create -f -
       apiVersion: v1
       kind: Project
       metadata:
         annotations:
           openshift.io/description: This is an example project to demonstrate OpenShift v3
           openshift.io/display-name: Hello OpenShift
           openshift.io/requester: system:admin
           openshift.io/sa.scc.mcs: s0:c13,c7
           openshift.io/sa.scc.supplemental-groups: 1000170000/10000
           openshift.io/sa.scc.uid-range: 1000170000/10000
         creationTimestamp: null
         name: {{ project_name }}
       spec:
         finalizers:
           - openshift.io/origin
           - kubernetes
       status:
       EOF

{#
query_example:
  http.query:
    - name: 'https://localhost:8443/healthz/ready'
    - status: 'status: 200'
#}

"Get all projects":
  cmd.run:
   - runas: {{ runuser }}
   - name: |
       {{ oc_cli }} --config=$HOME/.kube/config  describe projects {{ project_name }}

   - onlyif: {{ oc_cli }} --config=$HOME/.kube/config  get project {{ project_name }}  || echo 0


"delete project":
  cmd.run:
   - runas: {{ runuser }}
   - name: |
       {{ oc_cli }} --config=$HOME/.kube/config  delete projects {{ project_name }}

   - onlyif: {{ oc_cli }} --config=$HOME/.kube/config  get project {{ project_name }}
