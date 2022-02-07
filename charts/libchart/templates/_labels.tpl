{{- define "libchart.labels" -}}
app: {{ .Release.Namespace }}
svc: {{ .Release.Name }}
{{- end }}