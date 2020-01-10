variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name" {
  description = "A suffix to append to the default cluster name"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "zone" {
  description = "The zone to host the cluster in"
}

variable "ip_range_pods" {
  description = "The ip range for pods"
}

variable "ip_range_services" {
  description = "The ip range for services"
}
