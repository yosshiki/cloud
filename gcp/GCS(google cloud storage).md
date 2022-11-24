## prerequisite  
https://cloud.google.com/storage/docs/introduction?hl=ja  

https://cloud.google.com/storage/docs/creating-buckets?hl=ja#storage-create-bucket-gcloud  

## CLI  
### create  
~~~bash
BUCKET_NAME="testbucketyyyymmdd"
REGION="ASIA-NORTHEAST1"
PROJECT_ID="your project"
STORAGE_CLASS="standard"
KEY_1="owner"
VALUE_1=""
  
gcloud alpha storage buckets create gs://${BUCKET_NAME} \
    --project=${PROJECT_ID} \
    --default-storage-class=${STORAGE_CLASS} \
    --location=${REGION} \
    --uniform-bucket-level-access

gsutil label ch -l \
    ${KEY_1}:${VALUE_1} \
    gs://${BUCKET_NAME}
~~~
### check  
~~~bash
gcloud alpha storage ls
~~~
### check detail  
~~~bash
# size
gsutil du -s gs://${BUCKET_NAME}
# describe
gsutil ls -L -b gs://${BUCKET_NAME}
# object ls
gcloud alpha storage ls --recursive gs://${BUCKET_NAME}
~~~

### upload
~~~bash
LOCAL_OBJECT="./test.txt"
gsutil cp ${LOCAL_OBJECT} gs://${BUCKET_NAME}/

# check
gcloud alpha storage ls --recursive gs://${BUCKET_NAME}
~~~

### download
~~~bash
OBJECT="test.txt"
rm test.txt
gsutil cp gs://${BUCKET_NAME}/${OBJECT} ${LOCAL_OBJECT}
~~~

## GUI  
