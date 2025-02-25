const generateFile = async () => {
    setLoading(true);
    setError(null); 

    try {
        const response = await fetch("http://127.0.0.1:5000/generate-file", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                recipient_email: "recipient@example.com",
                query: "SELECT * FROM your_dataset.your_table LIMIT 1000"
            })
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || "Unknown error");
        }

        setTimeout(() => setLoading(false), 10000); // Wait 10s, then remove loader
    } catch (error) {
        setLoading(false);
        setError(error.message);
    }
};




///////////////////////////////////////////////////////////////////




    from flask import Flask, request, jsonify
from google.cloud import bigquery, storage
import pandas as pd
import requests
import concurrent.futures
import os

app = Flask(__name__)

# GCP Config
BUCKET_NAME = "your-gcs-bucket"
CSV_FILENAME = "exported_data.csv"
AIRFLOW_TRIGGER_URL = "http://your-airflow-url/api/v1/dags/send_email_dag/dagRuns"

# Initialize clients
bq_client = bigquery.Client()
storage_client = storage.Client()
executor = concurrent.futures.ThreadPoolExecutor()

def upload_to_gcs(bucket_name, local_file_path, file_name):
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)
    blob.upload_from_filename(local_file_path)
    return f"https://storage.googleapis.com/{bucket_name}/{file_name}"

def trigger_dag(file_url, recipient_email):
    payload = {
        "conf": {
            "file_url": file_url,
            "recipient_email": recipient_email
        }
    }
    headers = {"Content-Type": "application/json"}
    response = requests.post(AIRFLOW_TRIGGER_URL, json=payload, headers=headers)
    print(f"DAG Trigger Response: {response.json()}")

def process_file_and_trigger_dag(query, recipient_email):
    try:
        df = bq_client.query(query).to_dataframe()
        if df.empty:
            print("No data found.")
            return
        
        local_path = f"/tmp/{CSV_FILENAME}"
        df.to_csv(local_path, index=False)
        file_url = upload_to_gcs(BUCKET_NAME, local_path, CSV_FILENAME)
        trigger_dag(file_url, recipient_email)
    except Exception as e:
        print(f"Error: {str(e)}")

@app.route('/generate-file', methods=['POST'])
def generate_file():
    try:
        data = request.get_json()
        recipient_email = data.get("recipient_email")
        query = data.get("query")
        
        if not recipient_email or not query:
            return jsonify({"error": "Missing parameters"}), 400
        
        try:
            df = bq_client.query(query).to_dataframe()
            if df.empty:
                return jsonify({"message": "Query successful, but no data found."}), 200
        except Exception as e:
            return jsonify({"error": "Invalid query", "details": str(e)}), 400
        
        executor.submit(process_file_and_trigger_dag, query, recipient_email)
        return jsonify({"message": "Processing in background."}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)







////////////////////////////////////////////////////////////////////////////////////////



from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
import smtplib
from email.mime.text import MIMEText
import json

# Email Config (Update These)
EMAIL_SENDER = "your-email@gmail.com"
EMAIL_PASSWORD = "your-app-password"  # Use App Password if needed
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 465

def send_email(**kwargs):
    """Extracts the file URL and recipient email from the trigger payload and sends an email."""
    conf = kwargs["dag_run"].conf  # Retrieve parameters from API call
    
    file_url = conf.get("file_url")
    recipient_email = conf.get("recipient_email")

    if not file_url or not recipient_email:
        raise ValueError("Missing file_url or recipient_email in DAG config.")

    subject = "Your CSV File is Ready"
    body = f"Your file has been generated.\nDownload it here: {file_url}"

    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = EMAIL_SENDER
    msg["To"] = recipient_email

    try:
        server = smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT)
        server.login(EMAIL_SENDER, EMAIL_PASSWORD)
        server.sendmail(EMAIL_SENDER, recipient_email, msg.as_string())
        server.quit()
        print("Email sent successfully!")
    except Exception as e:
        print("Failed to send email:", str(e))
        raise

# Define DAG
default_args = {"owner": "airflow", "start_date": days_ago(1)}
dag = DAG(
    "send_email_dag",
    default_args=default_args,
    schedule_interval=None,  # Only triggered via API
    catchup=False,
)

# Define Task
send_email_task = PythonOperator(
    task_id="send_email_task",
    python_callable=send_email,
    provide_context=True,
    dag=dag,
)

send_email_task








