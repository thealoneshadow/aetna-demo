import csv
import io
from flask import Flask, Response, jsonify
from google.cloud import bigquery

app = Flask(__name__)
client = bigquery.Client()

@app.route('/fetch-data', methods=['GET'])
def fetch_data():
    query = "SELECT * FROM your_table LIMIT 5000000"  # Adjust as needed
    query_job = client.query(query)

    if query_job is None:
        return jsonify({"error": "Query returned no data"}), 204

    # ✅ Streaming Generator Function
    def stream_csv():
        output = io.StringIO()
        writer = csv.writer(output)

        # ✅ Write Headers
        writer.writerow([field.name for field in query_job.schema])
        yield output.getvalue()
        output.seek(0)
        output.truncate(0)

        # ✅ Stream rows dynamically (chunk-by-chunk)
        for row in query_job:
            writer.writerow(row.values())
            yield output.getvalue()  # Send data immediately
            output.seek(0)
            output.truncate(0)

    return Response(
        stream_csv(),
        mimetype="text/csv",
        headers={
            "Content-Disposition": "attachment; filename=data.csv",
            "Transfer-Encoding": "chunked"
        }
    )

if __name__ == '__main__':
    app.run()



  const csvText = await response.data.text();

        // ✅ Parse CSV into an Array of Arrays
        const rows = csvText.split("\n").map(row => row.split(","));

        // ✅ Convert to Excel Format
        const worksheet = XLSX.utils.aoa_to_sheet(rows);
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");

        // ✅ Trigger Excel Download
        XLSX.writeFile(workbook, "data.xlsx");
        
        console.log("Excel downloaded successfully!");
