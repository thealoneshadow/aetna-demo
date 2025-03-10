const ExportToExcel = ({ data, fileName = "data.xlsx" }) => {
  const exportToExcel = () => {
    const worksheet = XLSX.utils.json_to_sheet(data);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");
    
    const excelBuffer = XLSX.write(workbook, { bookType: "xlsx", type: "array" });
    const blob = new Blob([excelBuffer], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8" });
    saveAs(blob, fileName);
  };


import requests

def trigger_airflow_dag(dag_id, email, gcs_url):
    airflow_api_url = f"http://your-airflow-host/api/v1/dags/{dag_id}/dagRuns"
    headers = {"Content-Type": "application/json", "Authorization": "Bearer YOUR_AIRFLOW_TOKEN"}
    
    payload = {
        "conf": {
            "email": email,
            "file_url": gcs_url
        }
    }

    response = requests.post(airflow_api_url, json=payload, headers=headers)
    return response.json()


from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    email = request.form['email']
    
    if not file:
        return jsonify({"error": "No file uploaded"}), 400

    gcs_url = upload_to_gcs("your-bucket-name", file, file.filename)
    dag_response = trigger_airflow_dag("your_dag_id", email, gcs_url)
    
    return jsonify({
        "message": "File uploaded successfully!",
        "file_url": gcs_url,
        "dag_status": dag_response
    })

if __name__ == '__main__':
    app.run(debug=True)




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




from google.cloud import orchestration_airflow

def trigger_dag_with_params(project_id, location, composer_env_name, dag_id, email, link):
    """
    Triggers an Airflow DAG in Cloud Composer and passes parameters.

    Args:
        project_id (str): Google Cloud project ID.
        location (str): Location of the Composer environment.
        composer_env_name (str): Name of the Composer environment.
        dag_id (str): DAG ID to trigger.
        email (str): Email to pass to DAG.
        link (str): Link to pass to DAG.

    Returns:
        dict: Response from Google Cloud Composer.
    """
    client = orchestration_airflow.environments_v1.EnvironmentsClient()

    # Construct the request with parameters
    environment_path = client.environment_path(project_id, location, composer_env_name)
    request = {
        "environment": environment_path,
        "dag_run_id": f"manual_{dag_id}",
        "dag_id": dag_id,
        "conf": {
            "email": email,
            "link": link
        }
    }

    # Trigger the DAG
    operation = client.trigger_dag(request)
    response = operation.result()





















  import json
import uuid
from urllib.parse import unquote
from src.config import get_value
from .blueprints import module_blueprints
from werkzeug.exceptions import Unauthorized
from flask import jsonify, request, Response, stream_with_context, send_file
from google.cloud.spanner_dbapi import connect
from src.config import get_value
from google.cloud import bigquery
from src.connector.spanner_connector import getSpannerDbInstance
import io
import csv
import pandas as pd
from google.auth import default
import smtplib
from google.cloud import storage
from google.cloud import orchestration_airflow



creds, _ = default()
service_account_email = creds.service_account_email  # Extract email
client = bigquery.Client()


def trigger_dag_with_params(project_id, location, composer_env_name, dag_id, email, link):
    
    client = orchestration_airflow.environments_v1.EnvironmentsClient()

    # Construct the request with parameters
    environment_path = client.environment_path(project_id, location, composer_env_name)
    request = {
        "environment": environment_path,
        "dag_run_id": f"manual_{dag_id}",
        "dag_id": dag_id,
        "conf": {
            "email": email,
            "link": link
        }
    }

    # Trigger the DAG
    operation = client.trigger_dag(request)
    response = operation.result()

    print("DAG triggered successfully:", response)
    return response

def extract_columns_from(query):
    """Extract column names from the SELECT query."""
    # Simple regex to extract columns from SELECT clause
    select_clause = query.split("FROM")[0].replace("SELECT", "").strip()
    columns = [col.strip() for col in select_clause.split(",")]
    return columns

def upload_to_gcs(bucket_name, file_stream, destination_blob_name):
    
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    
    # Upload the file stream to GCS
    blob.upload_from_file(file_stream, content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

    # Make the file public (so the URL will not expire)
    blob.make_public()

    # Return the permanent public URL
    return blob.public_url

    
def customCharQueriesEmail():
    try:

        data = request.get_json()

        value= data["table"]
        
        row_ct =  f"""{value}
            """
        query_job = client.query(row_ct)

        print(query_job)
        results = query_job.result() 
       


        def stream():
            column_names = [field.name for field in results.schema]
            yield ",".join(column_names) + "\n"

            for row in query_job:
                yield ",".join(map(str, row)) + "\n"

            # gcs_url = upload_to_gcs("your-bucket-name", file, file.filename)

        return Response(
            stream_with_context(stream()),
            mimetype="text/csv",
            headers={"Content-Disposition": "attachment; filename=data.csv"},
        )
           

    except Exception as e:  
        print(e)
        return jsonify({'error': 'Internal server error'}), 500
    
    
@module_blueprints.route('/get-custom-report-chart-queries-email', methods=['POST']) # type: ignore
def get_custom_report_email():
    # result = database.run_in_transaction(getAllDashboards)
    result = customCharQueriesEmail()
    return result



















  

    print("DAG triggered successfully:", response)
    return response
