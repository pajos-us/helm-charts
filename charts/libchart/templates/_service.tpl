{{ define "libchart.service" }}
{{ $create_svc := false }}
{{- range .containers }}
{{- range .ports }}
{{- if .service }}
{{ $create_svc = true }}
{{- end }}
{{- end }}
{{- end }}
{{- if $create_svc }}
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}
  labels:
{{ include "libchart.labels" . | indent 4 }}
spec:
  type: "ClusterIP"
  ports:
{{- range .containers }}
{{- range .ports }}
{{- if .service }}
  - port: {{ .service.port }}
    targetPort: {{ .target }}
    protocol: {{ default "TCP" .protocol }}
    name: {{ .name }}
{{- end }}
{{- end }}
{{- end }}
  selector:
{{ include "libchart.labels" . | indent 4 }}
{{- end }}
{{ end }}