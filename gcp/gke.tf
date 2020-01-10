#GCE auth
provider "google" {
  version = "~> 2.18.0"
  region  = var.region
  credentials = file("./gcp/credentials.json")
  project     = var.project_id
}


module "gke" {
  source                 = "github.com/terraform-google-modules/terraform-google-kubernetes-engine"
  project_id             = var.project_id
  name                   = "cluster-${var.cluster_name}"
  regional               = true
  region                 = var.region
  network                = "default"
  subnetwork             = "default"
  ip_range_pods          = var.ip_range_pods
  ip_range_services      = var.ip_range_services
  create_service_account = true

  #node pool with horizontal auto scaling
  node_pools = [
    {
      name               = "${var.cluster_name}-pool"
      machine_type       = "n1-standard-1"
      min_count          = 1
      max_count          = 4
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1 #initial node count per zone
    },
  ]
}
