{{- define "libchart.pdb" -}}
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: {{ .Release.Name }}
spec:
  {{- if .Values.pdb }}
  minAvailable: {{ default 1 .Values.pdb.minAvailable }}
  {{- if .Values.pdb.maxUnavailable }}
  maxUnavailable: {{ .Values.pdb.maxUnavailable }}
  {{ end }}
  {{ else }}
  minAvailable: 1
  {{- end }}
  selector:
    matchLabels:
{{ include "libchart.labels" . | indent 6}}
{{ end -}}