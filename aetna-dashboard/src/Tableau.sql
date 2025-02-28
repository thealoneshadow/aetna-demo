#**************************************************************************************
# STEP 1 - (A): To import library needed for the operation & (B): Set Config variables
#**************************************************************************************

# ~~~(A) Set Config Variables~~~
import airflow
from airflow import DAG
from airflow import models
from airflow.models import Variable
from airflow.models import TaskInstance
from airflow.utils.dates import days_ago
from airflow.utils.email import send_email
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import BranchPythonOperator
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dagrun_operator import TriggerDagRunOperator
from airflow.operators.dummy import DummyOperator
import google.auth
from google.auth import impersonated_credentials
from google.cloud import storage
from google.cloud import bigquery
import zipfile
import pandas as pd
import os, sys
from io import BytesIO
import ast
import datetime
from datetime import timedelta, datetime
import json
import requests
from dateutil.relativedelta import relativedelta


CUR_DIR = os.path.abspath(os.path.dirname(__file__))
DAG_PATH = os.environ.get('DAGS_FOLDER')
PROJECT_ID = os.environ.get("GCP_PROJECT")
GCP_ENV = PROJECT_ID.split("-")[-1]
GCP_ENV = PROJECT_ID.split("-")[-3]
#GCP_LOB = PROJECT_ID.split("-")[-2]
environment=GCP_ENV.upper()


#Reading Config File
config_path = f"{CUR_DIR}/config"
with open(config_path+'/config.json') as f:
    config = json.load(f)


# ~~~~~~~ Static Configuration Variables ~~~~~~~ #


TENANT = "edp-"+environment.lower()+"-mpm-analyics"
DAG_REPO = "mpm_analytics_gcp"
#CHANGE LAST TEXT AS PER DAG FUNCUONLAITY
DAG_ID=f"{TENANT}-{DAG_REPO}-mamls_member_detail_recon"

#RESOURCE_SA = "gchcb-msa-ontpd@anbc-hcb-dev.iam.gserviceaccount.com"
#CONNECT_SA = "msa-hcb-connect@anbc-hcb-dev.iam.gserviceaccount.com"
#group_name="gchcb-msa-ontpd"

dev_databases = config['CONFIG']['dev_databases']
#test_databases = config['CONFIG']['test_databases']
prod_databases = config['CONFIG']['prod_databases']

if environment == "DEV":
    RESOURCE_SA="gcentanalyticsconpdd@edp-dev-serviceops.iam.gserviceaccount.com"
elif environment == "PROD":
    RESOURCE_SA = "gcmpmconppp@edp-prod-serviceops.iam.gserviceaccount.com"
else:
    print("GCP Environment UNKNOWN")


# Initialize the Google Cloud Storage client
credential, project= google.auth.default()
target_credentials= impersonated_credentials.Credentials(credential, target_principal= RESOURCE_SA, target_scopes= ["https://www.googleapis.com/auth/cloud-platform"])



if environment == "DEV":
    #msa_sa_connect="growth-anlyt-hcb-connect@anbc-hcb-dev.iam.gserviceaccount.com"
    #group_name="gchcb-growth-anlyt-ontpd"
    output_db={
        "source_midas":dev_databases["midas_src"],
        "source_mamls":dev_databases["mamls_src"],
        "source_pad":dev_databases["pad_src"],
        "output_midas":dev_databases["midas_cns"],
        "output_mamls":dev_databases["mamls_cns"],
        "output_pad":dev_databases["pad_cns"],
        "output_view_midas":dev_databases["midas_cns_view"],
        "output_view_mamls":dev_databases["mamls_cns_view"],
        "output_view_pad":dev_databases["pad_cns_view"]
        }
elif environment == "PROD":
    #msa_sa_connect = "growth-anlyt-hcb-connect@anbc-hcb-prod.iam.gserviceaccount.com"
    #group_name = "gchcb-growth-anlyt-ontpp"
    output_db={
        "source_midas":prod_databases["midas_src"],
        "source_mamls":prod_databases["mamls_src"],
        "source_pad":prod_databases["pad_src"],
        "output_midas":prod_databases["midas_cns"],
        "output_mamls":prod_databases["mamls_cns"],
        "output_pad":prod_databases["pad_cns"],
        "output_view_midas":prod_databases["midas_cns_view"],
        "output_view_mamls":prod_databases["mamls_cns_view"],
        "output_view_pad":prod_databases["pad_cns_view"]     
        }

# (i) - Labels for GCP Resources
COST_CENTER = config['CONFIG']['LABELS']['COSTCENTER']
REGION = config['CONFIG']['PROJECT_INFO']['LOCATION']
USER = config['CONFIG']['LABELS']['USER']
USER_EMAIL = config['CONFIG']['LABELS']['USEREMAIL']
sql_folder_path = f"{CUR_DIR}"+"/scripts/SQL/"
abs_sql_path = os.path.join(DAG_PATH, sql_folder_path)
utils_path = f"{CUR_DIR}"+"/utilities"

# (ii) - Required for DAG
EMAIL = config['CONFIG']['EMAILS']['FROM_EMAIL']
CC_EMAIL = config['CONFIG']['EMAILS']['CC_EMAIL']
CC_EMAIL = ast.literal_eval(CC_EMAIL)
TO_EMAIL = config['CONFIG']['EMAILS']['MAMLS_TO_EMAIL']
TO_EMAIL = ast.literal_eval(TO_EMAIL)
OWNER_NAME = config['CONFIG']['LABELS']['OWNER_NAME']

# (iii) - Required for SQL
dev_databases = config['CONFIG']['dev_databases']
prod_databases = config['CONFIG']['prod_databases']

def months_ago(months: int, from_date: datetime = None) -> datetime:
    """    Calculates a date that is a specified number of months before a given date.          Args:         months: The number of months to subtract.         from_date: The starting date (defaults to current date and time if None).          Returns:         A datetime object representing the calculated date.     """
    if from_date is None:
        from_date = datetime.now()
    return from_date - relativedelta(months=months)

#**************************************************************************************
# STEP 2 - Default Argument
#**************************************************************************************

default_args = {
                'start_date': months_ago(1),
                'project_id': PROJECT_ID,
                'retries': 0,
                'owner': 'MSA DATA SCIENCE', ###
                'depends_on_past': False,
                'email': ['jains6@AETNA.com'], ###
                'email_on_failure': True,
                'email_on_retry': False,
                'retry_delay': timedelta(minutes=2)
               }

DAG_TAGS = [
    f"tenant:{TENANT}",
    "owner:jains6@aetna.com",
    f"cost-center:{COST_CENTER}",
    f"msa-project:MPM"
]

_LABELS_ = {
                "owner": OWNER_NAME,
                "environment": environment.lower(),
                "org": "medicare",
                "tenant": TENANT,
                "lob": "hcb"
             }
LABELS="Options (labels="+str(list(_LABELS_.items()))+")"
LABELS_DICT = {"LABELS":LABELS}

params = dict( output_db.items() | dev_databases.items() | prod_databases.items() | LABELS_DICT.items() )

    
def execute_bigquery(ti):
        print(f"Executing BigQuery script...")
        client = bigquery.Client(credentials=target_credentials)
        
        #BigQuery query
        query = f"""
        SELECT
            COUNT(MBI) AS MM,
            Contract_PBP AS Contract_PBP,
            DOS AS DOS
        FROM	
            `{output_db["output_mamls"]}.mamls_memberdetails`
        GROUP BY 
            Contract_PBP, 
            dos
            ;
        """
        query_job = client.query(query)
        results = query_job.result()

        # Convert query results to DataFrame
        rows = [dict(row) for row in results]
        df = pd.DataFrame(rows)

        # Save results to a CSV file in /tmp
        csv_path = f"/tmp/mamls_member_details_recon.csv"
        df.to_csv(csv_path, index=False)

        # Push the CSV path to XCom
        ti.xcom_push(key="csv_path", value=csv_path)

def send_notification(ti):
    # Retrieve CSV file path from XCom
    csv_path = ti.xcom_pull(task_ids="execute_bigquery", key="csv_path")
   

    # Prepare email content
    subject = f"Report - {datetime.now().strftime('%Y-%m-%d')}"
    body = """
    <html>
    <body>
        <p>Please find the attached results.</p>
    </body>
    </html>
    """

    # Send email with the CSV file as an attachment
    with open(csv_path, "rb") as f:
        send_email(
            to=TO_EMAIL,
            subject=subject,
            html_content=body,
            files=[csv_path]
        )
#**************************************************************************************
# STEP 3 - Define DAG: Set ID and assign default args and schedule interval
#**************************************************************************************
#0 8 * * *
with DAG(DAG_ID,
        schedule_interval='45 10 16,23 * *',
        default_args=default_args,
        tags=DAG_TAGS,
        template_searchpath=abs_sql_path,
        user_defined_macros=params
        ) as dag:

#**************************************************************************************
# Step 4: Define tasks for the DAG
#**************************************************************************************

        execute_bigquery = PythonOperator(
            task_id='execute_bigquery',
            provide_context=True,
            python_callable = execute_bigquery
        )

        notification_task = PythonOperator(   
            task_id='send_notification',
            provide_context=True,
            python_callable = send_notification
        )


#**************************************************************************************
# Step 5: Set up Dependencies for DAG ----- Trigger DAGs
#**************************************************************************************

        execute_bigquery >> notification_task

