variable "client_token" {
  description = "Client token to connect to GKE"
}

variable "endpoint" {
  description = "Endpoint to connect to GKE"
}

variable "ca_certificate" {
  description = "CA certificate to connect to GKE"
}

#cloud sql connection name. public connection
variable "instance_connection_name" {
  description = "SQL instance connection name"
}

#Cloud SQL password
variable "generated_user_password" {

}

#Cloud SQL service account
#variable "service_account_key"{}



