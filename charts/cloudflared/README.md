# cloudflared

Cloudflare Tunnel (cloudflared) daemon as a chart. Created due to cloudflare/helm-charts being unmaintained, 0.1.0 is backwards-compatible with future versions best-effort.

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2026.10.1](https://img.shields.io/badge/AppVersion-2026.10.1-informational?style=flat-square)

## Installation

### OCI Artifact (Preferred)

```bash
helm install cloudflared oci://ghcr.io/neeron/charts/cloudflared --version 0.2.0
```

### HTTP Repository

```bash
helm repo add neeron https://charts.neeron.me
helm repo update
helm install cloudflared neeron/cloudflared --version 0.2.0
```

## Source Code

* <https://github.com/neeron/charts/tree/main/charts/cloudflared>
* <https://github.com/cloudflare/cloudflared>
* <https://github.com/bjw-s-labs/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://bjw-s-labs.github.io/helm-charts | common | 5.3.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cloudflare | object | `{"account":"","enableWarp":false,"ingress":[],"secret":"","secretName":null,"tunnelId":"","tunnelName":""}` | Cloudflare Tunnel configuration |
| cloudflare.account | string | `""` | Cloudflare account tag / ID |
| cloudflare.enableWarp | bool | `false` | If true, turn on WARP routing for TCP |
| cloudflare.ingress | list | `[]` | Ingress rules telling cloudflared which local service to route incoming requests to. A default catch-all rule (- service: http_status:404) is automatically appended. |
| cloudflare.secret | string | `""` | The tunnel secret |
| cloudflare.secretName | string | `nil` | If defined, no secret is created by the chart and this existing secret is mounted instead |
| cloudflare.tunnelId | string | `""` | The ID of the tunnel |
| cloudflare.tunnelName | string | `""` | The name of the tunnel this instance will serve |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"cloudflare/cloudflared","tag":"{{ .Chart.AppVersion }}"}` | Container image configuration |
| image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy |
| image.repository | string | `"cloudflare/cloudflared"` | Container image repository |
| image.tag | string | `"{{ .Chart.AppVersion }}"` | Container image tag (defaults to chart appVersion) |
| replicaCount | int | `2` | Number of desired pod replicas |

## License

This work is licensed under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/).
