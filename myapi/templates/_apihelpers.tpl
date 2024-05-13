{{- define "replaceApiListenPath" -}}
{{- $apidef := .apidef -}}
{{- $listenPath := .listenPath -}}
{{- $result := regexReplaceAll "<<AUTO REPLACE LISTENPATH>>" $apidef $listenPath -}}
{{- printf "%s" $result -}}
{{- end -}}

{{- define "getServiceUrl" -}}
{{- $serviceName := .serviceName -}}
{{- $namespace := .namespace -}}
{{- $port := .port -}}
{{- printf "%s.%s.svc.cluster.local:%s" $serviceName $namespace $port -}}
{{- end -}}