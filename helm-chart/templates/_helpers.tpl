{{/*
Expand the name of the chart.
*/}}
{{- define "retail-store.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "retail-store.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "retail-store.labels" -}}
helm.sh/chart: {{ include "retail-store.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: retail-store
{{- end }}

{{/*
Selector labels for a given component
Usage: {{ include "retail-store.selectorLabels" (dict "name" "ui" "context" .) }}
*/}}
{{- define "retail-store.selectorLabels" -}}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- end }}

{{/*
Build the full image reference for an app service
Usage: {{ include "retail-store.appImage" (dict "repo" .Values.ui.image "context" .) }}
*/}}
{{- define "retail-store.appImage" -}}
{{- $registry := .context.Values.global.imageRegistry -}}
{{- $tag := .context.Values.global.imageTag -}}
{{- if .repo.tag }}{{- $tag = .repo.tag }}{{- end }}
{{- printf "%s/%s:%s" $registry .repo.repository $tag }}
{{- end }}
