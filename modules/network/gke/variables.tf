variable "project_id" {
  description = "The ID of your GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region where the network will be deployed."
  type        = string
}

variable "network_id" {
  description = "The VPC network cluster is deployed to."
  type        = string
}

variable "subnet_id" {
  description = "The VPC subnet cluster is deployed to."
  type        = string
}