variable "project_id" {
  description = "The ID of your GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region where the network will be deployed."
  type        = string
}

variable "mysql-root-pwd" {
  description = "The GCP region where the network will be deployed."
  type        = string
}

variable "network_id" {
  description = "The VPC network cluster is deployed to."
  type        = string
}

variable "private_vpc_connection_id" {
  description = "The VPC network cluster is deployed to."
  type        = string
}