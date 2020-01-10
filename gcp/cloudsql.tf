module "sql_db_mysql" {
  source           = "GoogleCloudPlatform/sql-db/google"
  project_id       = var.project_id
  region           = var.region
  zone             = var.zone
  name             = "${var.cluster_name}"
  database_version = "MYSQL_5_7" 


  database_flags = [
    {
      name  = "log_bin_trust_function_creators"
      value = "on"
    },
  ]
}

# private sql connection not working yet
# module "private-service-access" {
#   source      = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
#   project_id  = var.project_id
#   vpc_network = module.vpc.network_name
# }

# needed for k8s cloud proxy
#resource "google_service_account" "sql-sa" {
#  account_id   = "wordpress-sa"
#  display_name = "Cloud SQL SA for K8S"
#}

# data "google_service_account" "wordpress-sa" {
#   account_id = "wordpress-sa"
# }

# needed for k8s cloud proxy, depend on SA creation
#resource "google_service_account_key" "sql-key" {
#  service_account_id = google_service_account.sql-sa.name
#}

# needed for k8s cloud proxy, depend on SA creation
#resource "google_project_iam_member" "sql-sa-binding" {
# role    = "roles/cloudsql.client"
#  member  = "serviceAccount:${google_service_account.sql-sa.email}"
#}
