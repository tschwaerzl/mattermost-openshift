# Mattermost for OpenShift &nbsp; [![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Deploy%20Mattermost%20easily%20on%20OpenShift%20in%20no%20time%204&url=https://github.com/tschwaerzl/mattermost-openshift&via=tschwaerzl&hashtags=openshift,mattermost)

![Docker Build Status](https://img.shields.io/docker/build/tschwaerzl/mattermost-openshift.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/tschwaerzl/mattermost-openshift.svg)

OpenShift application template for Mattermost Team Edition.

## Table of contents

- [Quick start](#quick-start)
- [Contributors](#contributors)

## Quick start

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

## Contributors

Special thanks to everyone who contributed to getting the Mattermost OpenShift Template to the current state.  🙏

## Help

You tried to deploy and need help real quick? Message [@tschwaerzl](https://twitter.com/tschwaerzl) via Twitter or open an issue.