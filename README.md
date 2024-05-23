# Tyk APIOps demo

*Make API management as an integral part of development lifecycle*

## oas-httpbin

This repository contains a Helm chart for deploying a Tyk OAS (OpenAPI Specification) API using the Tyk Operator. The chart generates Tyk Operator CRDs (Custom Resource Definitions) from OpenAPI documents retrieved from Docker Hub.

### Features
- Update Tyk API document : Retrieve OpenAPI documents based on version tags and generate Tyk OAS API Definitions with following settings:
  - Apply "My Base API" template. The Base API template have detailed tracing, detailed activity log, and auth token enabled.
  - Auto generate middlewares for validate request
- Helm Chart for Tyk OAS API Deployment: Generate and deploy Tyk Operator CRDs.

### Using the Deploy Workflow
1. From the Actions menu, choose "Deploy workflow" and then "Run workflow".
2. Select API to deploy - `oas-httpbin`.
3. Enter the version tag to be deployed. The workflow assumes the following resources are available in DockerHub at `https://hub.docker.com/repositories/${{ secrets.DOCKERHUB_USERNAME }}`:
    - OpenAPI document named `openapi_schema.json` with tag `openapi_schema-${{ inputs.tag }}`
    - Docker image with tag `${{ inputs.tag }}`
4. When the workflow completes successfully, the Helm Chart will be updated in two places:
    - `image.tag` in `values.yaml` is updated to ${{ inputs.tag }}.
    - An updated API Definition is generated and commited to `/apidefinitions`.

### Installing the Application Using Helm
To install the application using Helm:
```
helm install <release_name> <path_to_chart>
```
Replace <release_name> with your desired release name and <path_to_chart> with the path to the Helm chart directory.

### Updating Values
#### Update `values.yaml` to configure your service
```yaml
image:
  repository: nginx
  pullPolicy: IfNotPresent
  tag: "" # Overrides the image tag whose default is the chart appVersion.
```
#### Update Tyk API configurations
```
tykapi:
  listenPath: /oas-httpbin
```
#### Add Tyk OAS API Definition JSON Files
Place Tyk OAS API Definition JSON files under the /apidefinitions directory. The following fields in the API Definitions can be auto-populated by the Helm Chart:
- Listen Path: If set as "<<AUTO REPLACE LISTENPATH>>" in the API definition file, the Helm Chart will replace it with the `tykapi.listenPath` field from the values file.
- Target URL: If set as "<<AUTO REPLACE TARGETURL>>" in the API definition file, the Helm Chart will replace it with the Kubernetes service URL.

### Usage
After installation, your API service and corresponding API Definitions will be deployed according to the configurations you've specified. You can manage and interact with your APIs using the Tyk Dashboard or API.
