{{/*
Return the application name.
Used for labels and naming consistency.
*/}}
{{- define "httpecho.name" -}}
httpecho
{{- end }}

{{/*
Return a fully qualified name for resources.
Combines release name and chart name to avoid application naming collisions.
*/}}
{{- define "httpecho.fullname" -}}
{{ .Release.Name }}-httpecho
{{- end }}

{{/*
Common labels applied to all resources.
Centralised here to keep labels consistent and easy to update.
*/}}
{{- define "httpecho.labels" -}}
app.kubernetes.io/name: {{ include "httpecho.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels used by Deployments, Services, etc.
Must remain stable to avoid breaking upgrades.
*/}}
{{- define "httpecho.selectorLabels" -}}
app.kubernetes.io/name: {{ include "httpecho.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
