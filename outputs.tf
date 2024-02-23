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
  value       =module.gke.kubernetes_cluster_host
  description = "GKE Cluster Host"
}