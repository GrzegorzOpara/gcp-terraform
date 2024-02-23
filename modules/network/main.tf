# vpc
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# GKE subnet
resource "google_compute_subnetwork" "subnet-gke" {
  name          = "${var.project_id}-subnet-gke"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}

# DB subnet
resource "google_compute_subnetwork" "subnet-db" {
  name          = "${var.project_id}-subnet-db"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.1.0/24"
}