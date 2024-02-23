output "region" {
  value       = var.region
  description = "Deployment Region"
}

output "project_id" {
  value       = var.project_id
  description = "Deployment Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.gke.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.gke.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "mysql_instance_name" {
  description = "The name of the database instance"
  value       = module.cloudsql.mysql_instance_name
}

output "mysql_private_ip_address" {
  description = "The private IPv4 address of the master instance."
  value       = module.cloudsql.mysql_private_ip_address
}