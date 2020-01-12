output "sql_private_ip" {
  value       = module.gcp.sql_host
}

output "wordpress_external_ip" {
  value       = module.k8s.wordpress_external_ip
}

