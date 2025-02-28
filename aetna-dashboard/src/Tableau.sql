#**************************************************************************************
# STEP 1 - (A): Import Libraries & (B): Set Config Variables
#**************************************************************************************

import airflow
from airflow import DAG
from airflow import models
from airflow.models import Variable
from airflow.models import TaskInstance
from airflow.utils.dates import days_ago
from airflow.utils.email import send_email
from airflow.operators.python_operator import PythonOperator
import google.auth
from google.auth import impersonated_credentials
from google.cloud import storage
from google.cloud import bigquery
import os
import json
import datetime
from datetime import timedelta, datetime
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# Load Environment Variables
CUR_DIR = os.path.abspath(os.path.dirname(__file__))
DAG_PATH = os.environ.get("DAGS_FOLDER")
PROJECT_ID = os.environ.get("GCP_PROJECT")
GCP_ENV = PROJECT_ID.split("-")[-3]
environment = GCP_ENV.upper()

# Load Config File
config_path = f"{CUR_DIR}/config"
with open(config_path+'/config.json') as f:
    config = json.load(f)

# Static Config
TENANT = "edp-"+environment.lower()+"-mpm-analytics"
DAG_REPO = "mpm_analytics_gcp"
DAG_ID = f"{TENANT}-{DAG_REPO}-email_notification"

# Set Service Account based on Environment
if environment == "DEV":
    RESOURCE_SA = "gcentanalyticsconpdd@edp-dev-serviceops.iam.gserviceaccount.com"
elif environment == "PROD":
    RESOURCE_SA = "gcmpmconppp@edp-prod-serviceops.iam.gserviceaccount.com"
else:
    print("GCP Environment UNKNOWN")

# Initialize Google Cloud Credentials
credential, project = google.auth.default()
target_credentials = impersonated_credentials.Credentials(
    credential, target_principal=RESOURCE_SA, target_scopes=["https://www.googleapis.com/auth/cloud-platform"]
)

# Email Config
EMAIL = config['CONFIG']['EMAILS']['FROM_EMAIL']
TO_EMAIL = config['CONFIG']['EMAILS']['MAMLS_TO_EMAIL']

#**************************************************************************************
# STEP 2 - Default Arguments
#**************************************************************************************

default_args = {
    'start_date': days_ago(1),
    'project_id': PROJECT_ID,
    'retries': 0,
    'owner': 'MSA DATA SCIENCE',
    'depends_on_past': False,
    'email': ['jains6@AETNA.com'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retry_delay': timedelta(minutes=2)
}

DAG_TAGS = [
    f"tenant:{TENANT}",
    "owner:jains6@aetna.com"
]

#**************************************************************************************
# STEP 3 - Email Sending Function
#**************************************************************************************

def send_dynamic_email(**kwargs):
    email = kwargs["params"].get("email")
    link = kwargs["params"].get("link")

    if not email or not link:
        raise ValueError("Missing email or link in request")

    smtp_server = "smtp.gmail.com"
    smtp_port = 587
    sender_email = EMAIL
    receiver_email = email

    # Email Content
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = "Your Requested Link"
    
    body = f"""
    <html>
    <body>
        <p>Hello,</p>
        <p>Here is your requested link: <a href="{link}">{link}</a></p>
        <p>Best Regards,<br>Airflow DAG</p>
    </body>
    </html>
    """
    message.attach(MIMEText(body, "html"))

    try:
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(sender_email, "your-email-password")  # Use App Password
        server.sendmail(sender_email, receiver_email, message.as_string())
        server.quit()
        print(f"✅ Email sent successfully to {receiver_email}")
    except Exception as e:
        print(f"❌ Error sending email: {e}")

#**************************************************************************************
# STEP 4 - Define DAG
#**************************************************************************************

with DAG(
    DAG_ID,
    schedule_interval=None,  # Manually triggered
    default_args=default_args,
    tags=DAG_TAGS
) as dag:

    send_email_task = PythonOperator(
        task_id="send_email_task",
        python_callable=send_dynamic_email,
        provide_context=True
    )

#**************************************************************************************
# STEP 5 - API Trigger
#**************************************************************************************

# Run this command to trigger the DAG with dynamic data
# curl -X POST "http://localhost:8080/api/v1/dags/email_notification/dagRuns" \
# -H "Content-Type: application/json" \
# --data '{
#     "conf": {
#         "email": "user@example.com",
#         "link": "https://example.com"
#     }
# }'

