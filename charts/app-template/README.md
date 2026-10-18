# app-template

Template Helm chart with the bjw-s common library

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

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://bjw-s-labs.github.io/helm-charts | common | 3.4.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controllers | object | `{"main":{"containers":{"main":{"image":{"pullPolicy":"IfNotPresent","repository":"nginx","tag":"1.27.0"},"resources":{"limits":{"memory":"128Mi"},"requests":{"cpu":"10m","memory":"32Mi"}}}},"replicas":1,"strategy":"RollingUpdate","type":"deployment"}}` | Workload controllers configuration |
| controllers.main.containers.main.image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy |
| controllers.main.containers.main.image.repository | string | `"nginx"` | Container image repository |
| controllers.main.containers.main.image.tag | string | `"1.27.0"` | Container image tag |
| controllers.main.containers.main.resources | object | `{"limits":{"memory":"128Mi"},"requests":{"cpu":"10m","memory":"32Mi"}}` | Resource limits and requests |
| controllers.main.replicas | int | `1` | Number of desired replicas |
| controllers.main.strategy | string | `"RollingUpdate"` | Rollout strategy |
| controllers.main.type | string | `"deployment"` | Controller type (deployment, daemonset, statefulset) |
| ingress | object | `{"main":{"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/","service":{"identifier":"main","port":"http"}}]}]}}` | Ingress configuration |
| ingress.main.className | string | `""` | Ingress class name |
| ingress.main.enabled | bool | `false` | Enable ingress |
| ingress.main.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","service":{"identifier":"main","port":"http"}}]}]` | Ingress host and path configurations |
| persistence | object | `{"data":{"enabled":false,"type":"emptyDir"}}` | Persistence configuration |
| persistence.data.enabled | bool | `false` | Enable persistence volume |
| persistence.data.type | string | `"emptyDir"` | Type of persistence volume |
| service | object | `{"main":{"controller":"main","ports":{"http":{"port":80}}}}` | Service configuration |
