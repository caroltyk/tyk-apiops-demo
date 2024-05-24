# Tyk APIOps demo

*Make API management as an integral part of development lifecycle*

## oas-httpbin

This repository contains a Helm chart for deploying a Tyk OAS (OpenAPI Specification) API using the Tyk Operator. The chart generates Tyk Operator CRDs (Custom Resource Definitions) from OpenAPI documents retrieved from Docker Hub.

### Features
1. Update Tyk OAS API Definition:
  - Retrieve OpenAPI document based on version tags and generate Tyk OAS API Definitions with following settings:
  - Apply API Template when importing from or patching with the OpenAPI document
  - Auto generate middlewares for validate request for endpoints defined in the OpenAPI document
  - The resulting API Definition is saved in Git at `./apidefinitions`.

2. Helm Chart for Tyk OAS API Deployment:
  - Helm template to generate Tyk Operator CRDs with latest API Definition at `./apidefinitions`.
  - Customisable API listen path `tykapi.listenPath`
  - Customisable Operator Context `tykapi.operatorContext`

3. Environment-specific settings are retrieved from GitHub Environment setting:
  - vars.TYK_DASHBOARD_URL: Base URL of Tyk Dashboard API
  - secrets.TYK_APIKEY: Access Key to Tyk Dashboard API
  - secrets.API_TEMPLATE_ID: Base Template used during import or patching

### Using the Deploy Workflow
1. From the Actions menu, choose "Deploy workflow" and then "Run workflow".
2. Select API to deploy - `oas-httpbin`.
3. Enter the version tag to be deployed. Two versions are supported now:
    - `v0.1.0`: httpbin service with /get endpoint
    - `v0.2.0`: httpbin service with /get and /status endpoints
4. Select Environment to deploy to
   - `tyk-cp` (Using a self-hosted environment)
   - `jupiter-staging` (Using a staging environment setup in Tyk Cloud: https://rural-gander-adm.aws-euw2.cloud-ara.tyk.io)
   
When the workflow completes successfully, the Helm Chart will be updated in two places:
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
