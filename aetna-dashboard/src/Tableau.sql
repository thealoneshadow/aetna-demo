def upload_to_gcs(bucket_name, file_stream, destination_blob_name):
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    # Upload file stream as binary
    file_stream.seek(0)  # Ensure stream is at the beginning
    blob.upload_from_file(file_stream, content_type='text/csv')

    # Make the file public (Permanent URL)
    blob.make_public()

    return blob.public_url



from google.cloud import storage

def upload_to_gcs(bucket_name, file_stream, destination_blob_name):
    """
    Uploads a file stream to Google Cloud Storage and returns a public URL.
    
    Args:
        bucket_name (str): Name of the GCS bucket.
        file_stream (BinaryIO): The file stream to upload.
        destination_blob_name (str): The destination path in the bucket.

    Returns:
        str: Public URL of the uploaded file.
    """
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    
    # Upload the file stream to GCS
    blob.upload_from_file(file_stream, content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

    # Make the file public (so the URL will not expire)
    blob.make_public()

    # Return the permanent public URL
    return blob.public_url


    return signed_url






row_ct = f"""{value}"""  
        query_job = client.query(row_ct)
        results = query_job.result()

        # Create a BytesIO buffer to store CSV data before uploading
        file_stream = io.BytesIO()
        writer = csv.writer(file_stream)

        # Write column names
        column_names = [field.name for field in results.schema]
        writer.writerow(column_names)

        # Write rows
        for row in query_job:
            writer.writerow(row)

        # Upload CSV to GCS
        file_stream.seek(0)  # Reset buffer position
        gcs_url = upload_to_gcs("your-bucket-name", file_stream, "exports/data.csv")

        # Trigger the Airflow DAG with email and GCS link
        trigger_dag_with_params(
            project_id="your-gcp-project",
            location="your-region",
            composer_env_name="your-composer-env",
            dag_id="your-dag-name",
            email=email,
            link=gcs_url
        )

        return jsonify({"message": "File streamed and uploaded", "url": gcs_url}), 200


