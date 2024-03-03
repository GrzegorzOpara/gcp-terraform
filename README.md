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
4. Grant **project editor** and **network admin** permissions to Cloud Build Service Account

    ```sh
    PROJECT_ID=$(gcloud config get-value project)

    CLOUDBUILD_SA="$(gcloud projects describe $PROJECT_ID --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com"

    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$CLOUDBUILD_SA --role roles/editor

    gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$CLOUDBUILD_SA --role roles/compute.networkAdmin
    ```
5. Grant permissions to Cloud Build Service Account to access GCS Bucket with state file (https://cloud.google.com/docs/terraform/resource-management/store-state#before_you_begin)

### Managed MySQL
1. Create password for wordpress main user and store it in secret manager

    ```sh
    printf "put-your-password-here" | gcloud secrets create db-wp-admin-pwd --data-file=-
    ```
3. Grant permissions to read secrets by Cloud Build Service Account

    ```sh
    PROJECT_ID=$(gcloud config get-value project)
    
    CLOUDBUILD_SA="$(gcloud projects describe $PROJECT_ID --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com"

    gcloud secrets add-iam-policy-binding db-wp-admin-pwd --member serviceAccount:$CLOUDBUILD_SA --role roles/secretmanager.secretAccessor
    ```

### SQL Proxy
1. Create Service Account for SQL Proxy service
```sh
SA_NAME=cloudsql-proxy
gcloud iam service-accounts create $SA_NAME --display-name $SA_NAME
```
2. Extract email address
```sh
SA_EMAIL=$(gcloud iam service-accounts list --filter=displayName:$SA_NAME --format='value(email)')
```
3. Add the **cloudsql.client** role to the service account
```sh
PROJECT_ID=$(gcloud config get-value project)
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SA_EMAIL --role roles/cloudsql.client
```
4. Create a key for the service account:
```sh
gcloud iam service-accounts keys create ./key.json --iam-account $SA_EMAIL
```
5. Update kubeconfig to point GKE cluster
```sh
gcloud container clusters get-credentials gopara-gke-lab-gke --region europe-west4
```
6. Create secrets for a db credentials and instance levels credentials
```sh
kubectl create secret generic cloudsql-db-credentials \
    --from-literal username=db-wp-admin \
    --from-literal password=$(gcloud secrets versions access latest --secret db-wp-admin-pwd)

kubectl create secret generic cloudsql-instance-credentials --from-file ./key.json
```
