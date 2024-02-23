# Wordpress deployment on GCP

## Prerequisites
### GCP
- GCS Bucket to store tf state file: 

  ``
  gcloud storage buckets create gs://gopara-gke-lab-gcs-tf --project gopara-gke-lab --location europe-west4 --uniform-bucket-level-access
  ``
  
### APIs
- Cloud Build API

  ``
  gcloud services enable cloudbuild.googleapis.com
  ``

- Secret Manager API

  ``
  gcloud services enable secretmanager.googleapis.com
  ``

- Cloud Resource Manager API

  ``
  gcloud services enable cloudresourcemanager.googleapis.com
  ``

- Cloud SQL Admin API

  ``
  gcloud services enable sqladmin.googleapis.com
  ``


### Cloud Build configuration
1. Create github host connection (https://pantheon.corp.google.com/cloud-build/connections/create)
2. Authentication - TBC
3. Link the terraform repository
4. Grant **project editor** permissions to Cloud Build Service Account

    ``
    PROJECT_ID=$(gcloud config get-value project)
    ``

    ``
    CLOUDBUILD_SA="$(gcloud projects describe $PROJECT_ID --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com"
    ``

    ``
    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$CLOUDBUILD_SA --role roles/editor
    ``
5. Grant permissions to Cloud Build Service Account to access GCS Bucket with state file (https://cloud.google.com/docs/terraform/resource-management/store-state#before_you_begin)

### Managed MySQL
1. Create password for MySQL root and store it in secret manager

    ``
    echo "put-your-password-here" | gcloud secrets create mysql-root-pwd --data-file=-
    ``
