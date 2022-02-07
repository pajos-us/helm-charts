{{- define "libchart.containers" -}}
{{- range .containers }}
{{- with . }}
- name: {{ required "value '.name' is required" .name }}
  image: {{ required "value 'image.name' is required" .image.name }}:{{ required "value 'image.tag' is required" .image.tag }}
  imagePullPolicy: {{ default "IfNotPresent" .image.pullPolicy }}
  {{ if .ports -}}
  {{- if gt (len .ports) 0 }}
  ports:
  {{- range .ports }}
  {{- with . }}
  - name: {{ .name }}
    containerPort: {{ .target }}
    protocol: {{ default "TCP" .protocol }}
  {{- end -}}
  {{- end -}}
  {{- end -}}
  {{- end }}
  {{ if .livenessprobe -}}
  livenessProbe:
{{ toYaml .livenessprobe | indent 4 }}
  {{- end }}
  {{ if gt (len .volumemounts) 0 }}
  volumeMounts:
  {{- range .volumemounts }}
  {{- with . }}
  - name: {{ .name }}
    mountPath: {{ .mountpath }}
  {{- end -}}
  {{- end -}}
  {{- end }}
  {{ if .readinessprobe -}}
  readinessProbe:
{{ toYaml .readinessprobe | indent 4 }}
  {{- end }}
  {{ if gt (len .configmaps) 0 -}}
  envFrom:
  {{- range .configmaps }}
  {{- with . }}
  - configMapRef:
      name: {{ $.Release.Name }}-{{ . | trim }}
  {{- end }}
  {{- end -}}
  {{- end -}}
{{- end }}
{{- end -}}
{{- end }}