# app-template

Template Helm chart with the bjw-s common library. Not a useful one to pull.

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Installation

### OCI Artifact (Preferred)

```bash
helm install app-template oci://ghcr.io/neeron/charts/app-template --version 0.1.0
```

### HTTP Repository

```bash
helm repo add neeron https://charts.neeron.me
helm repo update
helm install app-template neeron/app-template --version 0.1.0
```

## Source Code

* <https://github.com/neeron/charts/tree/main/charts/app-template>
* <https://github.com/bjw-s-labs/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://bjw-s-labs.github.io/helm-charts | common | 5.3.0 |

