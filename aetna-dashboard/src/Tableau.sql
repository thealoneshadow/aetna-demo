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

# Define environment-specific service accounts
SERVICE_ACCOUNTS = {
    "dev": "/path/to/dev-service-account.json",
    "staging": "/path/to/staging-service-account.json",
    "prod": "/path/to/prod-service-account.json",
}

# Get the current environment
ENV = os.getenv("ENV", "dev")  # Default to dev if not set
SERVICE_ACCOUNT_FILE = SERVICE_ACCOUNTS.get(ENV)

# Function to load service account and get credentials
def get_smtp_credentials():
    if not SERVICE_ACCOUNT_FILE:
        raise Exception("Service account file is missing!")

    credentials, _ = google.auth.load_credentials_from_file(SERVICE_ACCOUNT_FILE, scopes=["https://www.googleapis.com/auth/cloud-platform"])
    credentials.refresh(Request())  # Refresh the token if needed

    return credentials

# Function to send email
def send_email(email, link):
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
        # Connect to SMTP server
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, access_token)
        server.sendmail(sender_email, receiver_email, message.as_string())
        server.quit()

        print(f"Email sent successfully to {receiver_email}")
    except Exception as e:
        print(f"Error sending email: {e}")

# Define Airflow DAG
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2024, 2, 27),
    "email_on_failure": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

dag = DAG(
    "send_email_dag",
    default_args=default_args,
    description="DAG to send email using SMTP and service account",
    schedule_interval="@daily",
)

send_email_task = PythonOperator(
    task_id="send_email_task",
    python_callable=send_email,
    op_kwargs={"email": "user@example.com", "link": "https://example.com"},
    dag=dag,
)

send_email_task
