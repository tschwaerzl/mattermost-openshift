# Mattermost for OpenShift

OpenShift application template for Mattermost Team Edition.

## Getting started

### Prerequisites

You will need a OpenShift Origin 3 or Minishift up and running. Also Mattermost depends on PostgreSQL so please deploy it first.

### Installation

1. Create a new project if you don't have an existing one in OpenShift:
```bash
oc new-project mattermost
```

2. Create a secret named `mattermost-database` with `user` and `password` of the PostgreSQL database you deployed.
```bash
oc create secret generic mattermost-database --from-literal=user=mm_user --from-literal=password=mm_pass
```

3. Import the template
```bash
oc create -f mattermost.yaml
```

4. Deploy the newly created Mattermost from the Catalog into your project

5. Modify the ConfigMap `mattermost` to meet your PostgreSQL hostname, port and database name

6. Wait for the Pods to launch and access your new Mattermost by the created service.

Have fun.