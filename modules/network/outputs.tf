output "vpc_id" {
  description = "The ID of the created VPC."
  value       = google_compute_network.vpc.id
}

output "private_vpc_connection_id" {
  description = "The ID of the created private vpc connection."
  value       = google_service_networking_connection.private_vpc_connection.id
}

output "vpc_name" {
  description = "The name of the created VPC."
  value       = google_compute_network.vpc.name
}

output "gke_subnet_id" {
  description = "The ID of the GKE subnet."
  value       = google_compute_subnetwork.subnet-gke.id
}

output "db_subnet_id" {
  description = "The ID of the DB subnet."
  value       = google_compute_subnetwork.subnet-db.id
}
# Add more outputs for other subnets or important resources as needed 
