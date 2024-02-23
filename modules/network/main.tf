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
  private_ip_google_access = "true"
  ip_cidr_range = "10.10.1.0/24"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.project_id}-private-ip-pool"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.vpc.name
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}