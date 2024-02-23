provider "google" {
  project = "${var.project_id}"
  region = "${var.region}"
}

module "network" {
  source = "../../modules/network"

  project_id          = "${var.project_id}"
  region              = "${var.region}"
}

module "gke" {
  source = "../../modules/gke"

  version_prefix = "${var.version_prefix}"
  project_id          = "${var.project_id}"
  region              = "${var.region}"

}
