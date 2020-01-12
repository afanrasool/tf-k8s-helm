# Wordpress on GKE using Terraform and Helm

### This repo can be used to deploy a Wordpress deployment on GKE using an external db (Cloud SQL MySql) as backend. Infrastructure provisioning and App deployment are both done using Terraform. App roll out is being done by using Helm provider for Terraform.

### Repo Structure

```
.
├── README.md
├── charts
│   └── wordpress
├── gcp
│   ├── credentials.json
│   ├── gke.tf
│   ├── output.tf
│   ├── sql.tf
│   └── variables.tf
├── k8s
│   ├── helm.tf
│   ├── output.tf
│   ├── variables.tf
│   └── wordpress.tf
├── main.tf
├── output.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf
```

The provisioning part and the App deployment is segragated using modules. the `gcp` module is used for provisioning infrastructure while the `k8s` module is used to deploy the App. `main.tf` calls the two modules being used.


### //instructions to deploy from this repo

#### Pre-requisites
-   A service account for Terraform in GCP. Following roles have been tested to work with this setup : `Kubernetes Admin` , `Editor` , `Security Admin`.
-   Google Cloud SDK
-   Terraform 0.12
-   Store the keyfile for the service account created above in `gcp/credentials.json`
-   Activate the Service Networking API in your GCP Project. This is required to setup private service access for CloudSQL


#### Setup infra and deploy
- Clone this repo and fulfil the above mentioned pre-reqs
- Run terraform init to download any external modules
  ```bash
  terraform init
  ```
- Run terraform plan, to validate everything:
  ```bash
  terraform plan
  ```

- Apply
  ```bash
  terraform apply
  ```

### //caveats
- Terraform helm provider is using terraform version < v3. This meant I needed to set up Tiller with the required clusterrole. A step that could have been avoided if using Helm v3.

- One or two parameters have been hard codes. Even though these are fairly static, the best practice would be to variablize these as well.




### //extending to create CI/CD Pipeline

This part was not implemented as part of the repo. But the following can be implemented to create CI/CD pipeline so that any changes made to our helm charts can trigger a build and deploy pipeline to integrate those changes in an automated fashion:

- Install and configure Jenkins on your GKE cluster. This can be done using a helm release as well.
- Add a GitHub webhook to your jenkins pipeline for the repo that contains the helm chart
- Set up a container/pod template for Jenkins agents that has terraform binary so that we can call terraform in our pipeline.
- To call terraform from our pipelines would mean its no longer being done locally hence **Terraform remote state** would need to be utilized. Store the state in a GCS bucket in the same project to simplofy things
- Jenkins can utilize remote state and clone the git repo everytime the pipeline is triggered to do a `terraform apply` everytime changes are commited to the repo to which the webhook has been set.








### References:
- [Configuring Private Service Access on GCP](https://cloud.google.com/vpc/docs/configure-private-services-access)