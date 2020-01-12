variable "client_token" {
  description = "Client token to connect to GKE"
}

variable "endpoint" {
  description = "Endpoint to connect to GKE"
}

variable "ca_certificate" {
  description = "CA certificate to connect to GKE"
}


#Cloud SQL password
variable "generated_user_password" {

}

#Private ip address of cloudsql
variable "sql_private_ip" {

}
