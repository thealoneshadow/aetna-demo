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
from datetime import timedelta

def upload_to_gcs(bucket_name, file_stream, destination_blob_name, expiration_hours=1):
    """
    Uploads a file stream to Google Cloud Storage and returns a signed URL.
    
    Args:
        bucket_name (str): Name of the GCS bucket.
        file_stream (BinaryIO): The file stream to upload.
        destination_blob_name (str): The destination path in the bucket.
        expiration_hours (int): Signed URL expiration time in hours.

    Returns:
        str: Signed URL for the uploaded file.
    """
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)
    
    # Upload the file stream to GCS
    blob.upload_from_file(file_stream, content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    
    # Generate a signed URL valid for expiration_hours
    signed_url = blob.generate_signed_url(expiration=timedelta(hours=expiration_hours))

    return signed_url

