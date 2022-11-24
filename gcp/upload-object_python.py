"""
### before test in WSL
LOCAL_USER=""
GCP_USER=""
export GOOGLE_APPLICATION_CREDENTIALS=/home/${LOCAL_USER}/.config/gcloud/legacy_credentials/${GCP_USER}/adc.json
gcloud auth application-default login 
gcloud auth login
python3

import os
os.environ['GCLOUD_PROJECT']='your project'
import datetime 
bucket_name = "testbucket-"+(datetime.date.today()).strftime('%Y%m%d')

"""

### list blobs in a bucket ####

# https://cloud.google.com/storage/docs/listing-objects?hl=ja#prereq-code-samples
from google.cloud import storage
import datetime
bucket_name = "testbucket-"+(datetime.date.today()).strftime('%Y%m%d')
bucket_name

def list_blobs(bucket_name):
    """Lists all the blobs in the bucket."""
    storage_client = storage.Client()
    # Note: Client.list_blobs requires at least package version 1.17.0.
    blobs = storage_client.list_blobs(bucket_name)
    # Note: The call returns a response only when the iterator is consumed.
    for blob in blobs:
        print(blob.name)

### download most recent file to memory ###
from google.cloud import storage

blob_name = "test.txt"
def download_blob_into_memory(bucket_name, blob_name):
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    contents = blob.download_as_string()
    print(
        "Downloaded storage object {} from bucket {} as the following string: {}.".format(
            blob_name, bucket_name, contents
        )
    )

    
### download most recent file to local file ###
from google.cloud import storage

source_blob_name="test.txt"
destination_file_name = "./test.txt"
def download_blob(bucket_name, source_blob_name, destination_file_name):
    """Downloads a blob from the bucket."""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    blob.download_to_filename(destination_file_name)
    print(
        "Downloaded storage object {} from bucket {} to local file {}.".format(
            source_blob_name, bucket_name, destination_file_name
        )
    )
     
    
### upload file to blob ###
from google.cloud import storage

bucket_name = "testbucket-"+(datetime.date.today()).strftime('%Y%m%d')
source_file_name="./test2.txt"
destination_blob_name="test2.txt"

def upload_blob(bucket_name, source_file_name, destination_blob_name):
    """Uploads a file to the bucket."""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    blob.upload_from_filename(source_file_name)
    print(
        f"File {source_file_name} uploaded to {destination_blob_name}."
    )

    
### delete blobs in a bucket ###
from google.cloud import storage

def delete_blob(bucket_name, blob_name):
    """Deletes a blob from the bucket."""
    # bucket_name = "your-bucket-name"
    # blob_name = "your-object-name"

    storage_client = storage.Client()

    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    blob.delete()

    print(f"Blob {blob_name} deleted.")
