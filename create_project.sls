{% import_yaml "defaults.yaml" as defaults %}

{% set kubeconfig = defaults.get('kubeconfig') %}
{% set oc_cli = defaults.get('oc_cli') %}
{% set runuser = defaults.get('runuser') %}
{% set project_name = 'hello-openshift' %}

{% set l_project = '
apiVersion: v1
kind: ResourceQuota
metadata:
  name: core-object-counts
spec:
  hard:
    configmaps: "10"
    persistentvolumeclaims: "4"
    replicationcontrollers: "20"
    secrets: "10"
    services: "10"' %}

"create project":
  cmd.run:
   - runas: {{ runuser }}
   - onlyif: {{ oc_cli }} --config={{ kubeconfig }}  get project {{ project_name }} || echo 0
   - name: |
       cat <<EOF | {{ oc_cli }} --config=$HOME/.kube/config create -f -
       apiVersion: v1
       kind: Project
       metadata:
         annotations:
           openshift.io/description: This is an example project to demonstrate OpenShift v3
           openshift.io/display-name: Hello OpenShift
           openshift.io/requester: {{ runuser }}
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


"apply quota project":
  cmd.run:
   - runas: {{ runuser }}
   - onlyif: {{ oc_cli }} --config=$HOME/.kube/config  get project {{ project_name }}
   - name: |
       cat <<EOF | {{ oc_cli }} --config=$HOME/.kube/config create -n {{ project_name }} -f -
       apiVersion: v1
       kind: ResourceQuota
       metadata:
         name: resource-quota
       spec:
         hard:
           configmaps: "10"
           persistentvolumeclaims: "4"
           replicationcontrollers: "20"
           secrets: "10"
           services: "10"
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
