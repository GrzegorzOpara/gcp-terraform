terraform {
  backend "gcs" {
    bucket = "gopara-tf-state"
  }
}