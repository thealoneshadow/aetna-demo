from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
import smtplib
import os
import json
import google.auth
from google.auth.transport.requests import Request
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Service Account Setup
SERVICE_ACCOUNTS = {
    "dev": "/path/to/dev-service-account.json",
    "staging": "/path/to/staging-service-account.json",
    "prod": "/path/to/prod-service-account.json",
}
ENV = os.getenv("ENV", "dev")  # Default to dev
SERVICE_ACCOUNT_FILE = SERVICE_ACCOUNTS.get(ENV)

# Get SMTP Credentials
def get_smtp_credentials():
    if not SERVICE_ACCOUNT_FILE:
        raise Exception("Service account file is missing!")
    credentials, _ = google.auth.load_credentials_from_file(
        SERVICE_ACCOUNT_FILE, scopes=["https://www.googleapis.com/auth/cloud-platform"]
    )
    credentials.refresh(Request())  # Refresh token
    return credentials

# Function to send email (Now takes params from API request)
def send_email(**kwargs):
    email = kwargs["params"].get("email")
    link = kwargs["params"].get("link")

    if not email or not link:
        raise ValueError("Missing email or link in request")

    smtp_server = "smtp.gmail.com"
    smtp_port = 587
    credentials = get_smtp_credentials()
    access_token = credentials.token

    sender_email = "your-email@gmail.com"
    receiver_email = email

    # Create email content
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = "Your Link from Flask DAG"
    body = f"Hello,\n\nHere is your requested link: {link}\n\nBest Regards,\nFlask DAG"
    message.attach(MIMEText(body, "plain"))

    try:
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, access_token)
        server.sendmail(sender_email, receiver_email, message.as_string())
        server.quit()
        print(f"✅ Email sent successfully to {receiver_email}")
    except Exception as e:
        print(f"❌ Error sending email: {e}")

# Define DAG
default_args = {
    "owner": "airflow",
    "start_date": datetime(2024, 2, 27),
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}
dag = DAG(
    "send_email_dag",
    default_args=default_args,
    description="DAG to send emails with dynamic request data",
    schedule_interval=None,  # Manually triggered
)

send_email_task = PythonOperator(
    task_id="send_email_task",
    python_callable=send_email,
    provide_context=True,  # Allows passing request params
    dag=dag,
)

send_email_task
