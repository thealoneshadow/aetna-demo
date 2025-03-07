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
