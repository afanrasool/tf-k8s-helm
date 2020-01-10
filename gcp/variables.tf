variable "project_id" {
  description = "The project ID"
}

variable "cluster_name" {
  description = "the name of the instance"
}

variable "region" {
  description = "The region"
}

variable "zone" {
  description = "The zone"
}

variable "ip_range_pods" {
  description = "The range to use for pods"
}

variable "ip_range_services" {
  description = "The range to use for services"
}
