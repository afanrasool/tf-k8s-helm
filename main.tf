#GCE auth
provider "google" {  
  version = "~> 2.18.0"
  region  = var.region
  credentials = file("./gcp/credentials.json")
  project     = var.project_id
}

#module to deploy gcp resources
module "gcp" {
  source   = "./gcp"
  project_id  = "${var.project_id}"
  region   = "${var.region}"
  subnet_ip = "${var.subnet_ip}"
  secondary_subnet_ip_pod = "${var.secondary_subnet_ip_pod}"
  secondary_subnet_ip_svc = "${var.secondary_subnet_ip_svc}"
  cluster_name_suffix = "${var.cluster_name_suffix}"
  zones = "${var.zones}"
  ip_range_pods = "${var.ip_range_pods}"
  ip_range_services = "${var.ip_range_services}"
}

module "k8s" {
  source   = "./k8s"
  endpoint = "${module.gcp.kubernetes_endpoint}"
  client_token = "${module.gcp.client_token}"
  ca_certificate = "${module.gcp.ca_certificate}"
  instance_connection_name = "${module.gcp.instance_connection_name}"
  generated_user_password = "${module.gcp.sql_password}"
}


