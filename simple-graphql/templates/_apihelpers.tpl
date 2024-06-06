{{- define "getServiceUrl" -}}
{{- $serviceName := .serviceName -}}
{{- $namespace := .namespace -}}
{{- $port := .port -}}
{{- printf "http://%s.%s.svc.cluster.local:%s" $serviceName $namespace $port -}}
{{- end -}}