{{/*
Default values for the cloudflared workload and bjw-s common configuration.
Users can override any of these keys in their own values.yaml or --set flags.
*/}}
{{- define "cloudflared.values.defaults" -}}
{{- $replicas := default (default 2 .Values.replicas) .Values.replicaCount -}}
{{- $image := .Values.image | default dict -}}
{{- $imageRepo := default "cloudflare/cloudflared" $image.repository -}}
{{- $imageTag := default "{{ .Chart.AppVersion }}" $image.tag -}}
{{- $imagePullPolicy := default "IfNotPresent" $image.pullPolicy -}}
controllers:
  main:
    type: deployment
    replicas: {{ $replicas }}
    strategy: RollingUpdate
    annotations:
      checksum/config: '{{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}'
      checksum/secret: '{{ include (print $.Template.BasePath "/secret.yaml") . | sha256sum }}'
    serviceAccount:
      identifier: cloudflared
    containers:
      main:
        image:
          repository: {{ $imageRepo | quote }}
          tag: {{ $imageTag | quote }}
          pullPolicy: {{ $imagePullPolicy | quote }}
        args:
          - tunnel
          - --config
          - /etc/cloudflared/config/config.yaml
          - run
        probes:
          liveness:
            enabled: true
            custom: true
            spec:
              httpGet:
                path: /ready
                port: 2000
              failureThreshold: 1
              initialDelaySeconds: 10
              periodSeconds: 10
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          capabilities:
            drop:
              - ALL

defaultPodOptions:
  securityContext:
    runAsNonRoot: true
    runAsUser: 65532
  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
        - weight: 10
          podAffinityTerm:
            topologyKey: kubernetes.io/hostname
            labelSelector:
              matchExpressions:
                - key: app.kubernetes.io/name
                  operator: In
                  values:
                    - cloudflared

serviceAccount:
  cloudflared:
    enabled: true

persistence:
  config:
    enabled: true
    type: configMap
    name: '{{ include "cloudflared.fullname" . }}'
    globalMounts:
      - path: /etc/cloudflared/config
  creds:
    enabled: true
    type: secret
    name: '{{ default (include "cloudflared.fullname" .) .Values.cloudflare.secretName }}'
    globalMounts:
      - path: /etc/cloudflared/creds
{{- end -}}
