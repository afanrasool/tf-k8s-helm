# external ip to access wordpress
output "wordpress_external_ip" {
  value       = data.kubernetes_service.wordpress.load_balancer_ingress.0.ip
}
