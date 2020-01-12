#GCE auth
provider "google" {  
  version = "~> 2.18.0"
  region  = var.region
  credentials = file("./gcp/credentials.json")
  project     = var.project_id
}


#New VPC for GKE
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 1.0.0"

    project_id   = var.project_id
    network_name = "vpc-${var.cluster_name_suffix}"
    routing_mode = "GLOBAL"

    #primary subnet
    subnets = [
        {
            subnet_name           = "subnet-${var.cluster_name_suffix}"
            subnet_ip             = var.subnet_ip
            subnet_region         = var.region
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
        },
    ]
    #secondary ranges for pod IP space and service IP space
    secondary_ranges = {
      "subnet-${var.cluster_name_suffix}" = [
            {
                range_name    = "subnet-${var.cluster_name_suffix}-secondary-pod"
                #default pod/node is 110, need /24 per node, here CIDR should be /24 * # of nodes
                ip_cidr_range = var.secondary_subnet_ip_pod
            },
            {
                range_name    = "subnet-${var.cluster_name_suffix}-secondary-svc"
                ip_cidr_range = var.secondary_subnet_ip_svc
            },
        ]
    }
    #default route to internet
    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
    ]
}

#New GKE cluster
module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google"
  project_id             = var.project_id
  name                   = "cluster${var.cluster_name_suffix}"
  regional               = false
  region                 = var.region
  zones                  = var.zones
  network                = module.vpc.network_name
  subnetwork             = module.vpc.subnets_names[0]
  ip_range_pods          = "subnet-${var.cluster_name_suffix}-secondary-pod"
  ip_range_services      = "subnet-${var.cluster_name_suffix}-secondary-svc"
  create_service_account = true

  #node pool with horizontal auto scaling
  node_pools = [
    {
      name               = "${var.cluster_name_suffix}-pool"
      machine_type       = "n1-standard-2"
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




data "google_client_config" "default" {
} 
