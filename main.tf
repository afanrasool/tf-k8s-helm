data "google_client_config" "default" {
}

#GCE auth
provider "google" {  
  version = "~> 2.18.0"
  region  = var.region
  credentials = file("./gcp/credentials.json")
  project     = var.project_id
}

#GKE auth
provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gcp.kubernetes_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gcp.ca_certificate)
}

#module to deploy gcp resources
module "gcp" {
  source   = "./gcp"
  project_id  = "${var.project_id}"
  region   = "${var.region}"
  subnet_ip = "${var.subnet_ip}"
  cluster_name_suffix = "${var.cluster_name_suffix}"
  secondary_subnet_ip_pod = "${var.secondary_subnet_ip_pod}"
  secondary_subnet_ip_svc = "${var.secondary_subnet_ip_svc}"
  ip_range_pods = "${var.ip_range_pods}"
  ip_range_services = "${var.ip_range_services}"
  zones = var.zones
}


#module to deploy container apps. need output from gcp module
module "k8s" {
  source   = "./k8s"
  endpoint = "${module.gcp.kubernetes_endpoint}"
  client_token = "${module.gcp.client_token}"
  ca_certificate = "${module.gcp.ca_certificate}"
  generated_user_password = "${module.gcp.sql_password}"
  sql_private_ip = "${module.gcp.sql_host}"
}
