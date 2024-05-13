# tyk-apiops-demo

## Helm Chart for Deploying API and Publishing API Definition as Tyk OAS API CRDs

This Helm chart provides an example setup for deploying an API and publishing API Definitions as Tyk OpenAPI Specification (OAS) API Custom Resource Definitions (CRDs). It's designed to streamline the deployment process and simplify the configuration of your service.

### Prerequisites
- Kubernetes cluster
- Helm installed (version 3 or later)

### Installation
1. Copy this chart to your deployment repository.
2. Modify `values.yaml` to configure your service:
```yaml
image:
  repository: nginx
  pullPolicy: IfNotPresent
  # Overrides the image tag whose default is the chart appVersion.
  tag: ""
```
3. Add Tyk OAS API Definition json files under `/apidefinitions` directory
4. Install the Helm Chart:
```
helm install <release_name> <path_to_chart>
```

### Usage
After installation, your API service and corresponding API Definitions will be deployed according to the configurations you've specified. You can manage and interact with your APIs using the Tyk Dashboard or API.
