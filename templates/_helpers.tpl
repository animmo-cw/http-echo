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

{{/*
Build CoreWeave hostname from service name, orgID, and clusterName
Usage: {{ include "httpecho.coreweaveHostname" (dict "service" "strudel" "context" .) }}
Requires: orgID and clusterName to be set in values (via ArgoCD parameters or values file)
*/}}
{{- define "httpecho.coreweaveHostname" -}}
{{- $service := .service -}}
{{- $orgID := .context.Values.orgID | default "" -}}
{{- $clusterName := .context.Values.clusterName | default "" -}}
{{- if and $orgID $clusterName -}}
{{- printf "%s.%s-%s.coreweave.app" $service $orgID $clusterName -}}
{{- else -}}
{{- fail "orgID and clusterName must be set in values (set via ArgoCD parameters: orgID and clusterName)" -}}
{{- end -}}
{{- end }}
