envsubst < Dockerfile.template > Dockerfile
echo "CMD gsutil -m rsync -d -r \$S3_LOCATION \$GCS_LOCATION 2>&1" >> Dockerfile
envsubst < launch-s3-gcs-rsync.template > scripts/$COPY_JOB_NAME.sh
envsubst < s3-gcs-rsync-dag.template > $COPY_JOB_NAME-dag.py

gcloud builds submit --region=global --tag $IMAGE_LOCATION
rm -rf Dockerfile