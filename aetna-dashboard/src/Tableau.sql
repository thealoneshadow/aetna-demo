import os

service_account_email = os.getenv("GOOGLE_SERVICE_ACCOUNT_EMAIL")  # Check if set
if not service_account_email:
    from google.auth import default
    creds, _ = default()
    service_account_email = creds.service_account_email  # Extract email

print("Service Account Email:", service_account_email)



from flask import Flask, jsonify
from google.cloud import bigquery, storage
import pandas as pd
import os
import smtplib
from email.mime.text import MIMEText
from google.cloud.exceptions import GoogleCloudError

app = Flask(__name__)

# GCP Config
BUCKET_NAME = "your-gcs-bucket-name"
CSV_FILENAME = "exported_data.csv"
EMAIL_SENDER = "your-email@gmail.com"
EMAIL_PASSWORD = "your-email-password"  # Use App Password if needed

# Initialize clients
bq_client = bigquery.Client()
storage_client = storage.Client()

@app.route('/generate-file', methods=['POST'])
def generate_file():
    try:
        # Query BigQuery
        query = "SELECT * FROM your_dataset.your_table LIMIT 1000"  # Replace with actual query
        try:
            df = bq_client.query(query).to_dataframe()
        except GoogleCloudError as bq_error:
            return jsonify({"error": "Invalid query", "details": str(bq_error)}), 400

        # Save CSV locally
        local_path = f"/tmp/{CSV_FILENAME}"
        df.to_csv(local_path, index=False)

        # Upload CSV to GCS
        bucket = storage_client.bucket(BUCKET_NAME)
        blob = bucket.blob(CSV_FILENAME)
        blob.upload_from_filename(local_path)

        # Generate Public URL
        file_url = f"https://storage.googleapis.com/{BUCKET_NAME}/{CSV_FILENAME}"

        # Send email notification
        send_email("recipient@example.com", file_url)

        return jsonify({"message": "File generated!", "file_url": file_url})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

def send_email(recipient_email, file_url):
    subject = "Your CSV File is Ready"
    body = f"Your file has been generated.\nDownload it here: {file_url}"
    
    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = EMAIL_SENDER
    msg["To"] = recipient_email

    try:
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login(EMAIL_SENDER, EMAIL_PASSWORD)
        server.sendmail(EMAIL_SENDER, recipient_email, msg.as_string())
        server.quit()
        print("Email sent successfully!")
    except Exception as e:
        print("Failed to send email:", str(e))

if __name__ == '__main__':
    app.run(debug=True)
