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
  ip_range_pods = "${var.ip_range_pods}"
  ip_range_services = "${var.ip_range_services}"
  cluster_name = "${var.cluster_name}"
  zone = "${var.zone}"
}


