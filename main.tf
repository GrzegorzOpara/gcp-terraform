provider "google" {
  project = var.project_id
  region = var.region
}

module "network" {
  source = "./modules/network"

  project_id          = var.project_id
  region              = var.region
}

module "gke" {
  source = "./modules/gke"

  project_id          = var.project_id
  region              = var.region

}
