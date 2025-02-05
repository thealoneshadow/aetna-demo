import csv
import io
from flask import Flask, Response, jsonify
from google.cloud import bigquery

app = Flask(__name__)
client = bigquery.Client()

def extract_columns_from_query(query):
    """Extract column names from the SELECT query."""
    # Simple regex to extract columns from SELECT clause
    select_clause = query.split("FROM")[0].replace("SELECT", "").strip()
    columns = [col.strip() for col in select_clause.split(",")]
    return columns

@app.route('/fetch-data', methods=['GET'])
def fetch_data():
    query = "SELECT id, name, age FROM your_table LIMIT 5000000"  # Adjust your query
    query_job = client.query(query)

    try:
        results = query_job.result()  # Fetch results safely
    except Exception as e:
        return jsonify({"error": f"Query failed: {str(e)}"}), 500

    # ✅ Extract column names from the query string
    column_names = extract_columns_from_query(query)

    # ✅ Streaming Generator Function
    def stream_csv():
        output = io.StringIO()
        writer = csv.writer(output)

        # ✅ Write headers (from query)
        writer.writerow(column_names)
        yield output.getvalue()
        output.seek(0)
        output.truncate(0)

        # ✅ Stream rows dynamically (chunk-by-chunk)
        for row in results:
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
