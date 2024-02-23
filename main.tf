provider "google" {
  project = var.project_id
  region = var.region
}

data "google_secret_manager_secret_version" "mysql-root-pwd" {
 secret   = "mysql-root-pwd"
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
  network_id          = module.network.vpc_id
  subnet_id           = module.network.gke_subnet_id 
}

module "cloudsql" {
  source = "./modules/cloudsql"

  project_id                          = var.project_id
  region                              = var.region
  network_id                          = module.network.vpc_id
  private_vpc_connection_id           = module.network.private_vpc_connection_id
  mysql-root-pwd                      = data.google_secret_manager_secret_version.mysql-root-pwd.secret_data
}

