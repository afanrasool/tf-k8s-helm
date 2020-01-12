#needed for k8s module to authenticate
output "kubernetes_endpoint" {
  sensitive = true
  value     = module.gke.endpoint
}

#needed for k8s module to authenticate
output "client_token" {
  sensitive = true
  value     = data.google_client_config.default.access_token
}

#needed for k8s module to authenticate
output "ca_certificate" {
  value = module.gke.ca_certificate
  sensitive = true
}

output "service_account" {
  description = "The default service account used for running nodes."
  value       = module.gke.service_account
}


output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "svpc_host_project_id" {
  value       = module.vpc.svpc_host_project_id
  description = "Shared VPC host project id."
}

output "subnets_names" {
  value       = module.vpc.subnets_names
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = module.vpc.subnets_ips
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnets_regions" {
  value       = module.vpc.subnets_regions
  description = "The region where the subnets will be created"
}

output "subnets_private_access" {
  value       = module.vpc.subnets_private_access
  description = "Whether the subnets will have access to Google API's without a public IP"
}

output "subnets_flow_logs" {
  value       = module.vpc.subnets_flow_logs
  description = "Whether the subnets will have VPC flow logs enabled"
}

output "secondary_ranges" {
  value       = module.vpc.subnets_secondary_ranges
  description = "The secondary ranges associated with these subnets"
}

output "routes" {
  value       = module.vpc.routes
  description = "The routes associated with this VPC"
}

##needed for k8s module to connect to cloud sql
output "sql_password" {
  sensitive = true
  value = module.sql_db_mysql.generated_user_password
} 

##needed for k8s module to connect to cloud sql. public connection
output "instance_connection_name" {
  value = module.sql_db_mysql.instance_connection_name
}

##needed for k8s module to connect to cloud sql
#output "service_account_key" {
#  sensitive = true
#  value = google_service_account_key.sql-key.private_key
#}
