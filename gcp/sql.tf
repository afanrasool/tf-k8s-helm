resource "random_id" "name" {
  byte_length = 5
}

locals {
  mysql_version = "5.7"
}


module "sql_db_mysql" {
  source           = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version          = "2.0.0"
  project_id       = var.project_id
  region           = var.region
  zone             = "c"
  name             = "${var.cluster_name_suffix}-${random_id.name.hex}"
  database_version = "MYSQL_5_7" 

# Setting up private ip
  ip_configuration = {
    ipv4_enabled        = true
    require_ssl         = false
    private_network     = "projects/${var.project_id}/global/networks/vpc-${var.cluster_name_suffix}"
    # the authorized networks setting only applies to connecting using the instance's public IP
    authorized_networks = []
}

  database_flags = [
    {
      name  = "log_bin_trust_function_creators"
      value = "on"
    },
  ]
}

#Private Cloud SQL connection
module "private-service-access" {
  source      = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  project_id  = var.project_id
  vpc_network = module.vpc.network_name
}

