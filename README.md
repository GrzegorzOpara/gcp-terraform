# Wordpress deployment on GCP

## Prerequisites
### GCP
- GCS Bucket to store tf state file: 
``
gcloud storage buckets create gs://gopara-gke-lab-gcs-tf --project gopara-gke-lab --location europe-west4 --uniform-bucket-level-access
``

### Other