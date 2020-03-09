# Download the files from the website

Edit download_data.R to fill in user credentials and the destination path.

# Upload the files to Google Cloud Storage using Google Cloud SDK Shell

https://cloud.google.com/storage/docs/gsutil

# Create table raw from files in Cloud Storage

https://cloud.google.com/bigquery/docs/loading-data-cloud-storage

# Run other queries to create views with proper format
raw_view.sql - All observations, invalid observations set to NULL
raw_view_clean.sql - Only observations with valid values in all columns
