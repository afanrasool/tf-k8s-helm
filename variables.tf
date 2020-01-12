variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for pods"
}


variable "subnet_ip" {
    description = "The CIDR for the new subnet"
}

variable "secondary_subnet_ip_pod" {
    description = "The CIDR for the new subnet"
}

variable "secondary_subnet_ip_svc" {
    description = "The CIDR for the new subnet"
}  

variable "zones" {
     description = "The zones to build GKE. This is a remediation of some zones showing PROVISIONING"
}  

#variable "key_file" {
#    description = "previously generated key file"
#}  

#variable "cert_file" {
#    description = "previously generated cert file"
#}  
