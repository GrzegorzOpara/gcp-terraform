provider "google" {
  project = "${var.project_id}"
}

resource "google_storage_bucket" "dev-gcs" {
  name          = "${var.project_id}-gcs-bucket"
  location      = "${var.location}"
  
  storage_class = "STANDARD"

  force_destroy = true
  uniform_bucket_level_access = true
}