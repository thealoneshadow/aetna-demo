import signal
from flask import Flask, jsonify

app = Flask(__name__)

# Custom timeout handler
def timeout_handler(signum, frame):
    raise TimeoutError("Request took too long!")

@app.route("/export-csv", methods=["GET"])
def export_csv():
    signal.signal(signal.SIGALRM, timeout_handler)  
    signal.alarm(600)  # ⏳ Set timeout to 10 minutes (600 sec)

    # ✅ Your existing query code here
    query = "SELECT * FROM your_table"
    query_job = client.query(query)
    results = list(query_job)

    output = io.StringIO()
    writer = csv.writer(output)
    writer.writerow(results[0].keys())  # ✅ Column names
    for row in results:
        writer.writerow(row.values())

    signal.alarm(0)  # ✅ Reset timeout after successful execution

    return Response(
        output.getvalue(),
        mimetype="text/csv",
        headers={"Content-Disposition": "attachment; filename=data.csv"},
    )

if __name__ == "__main__":
    app.run(debug=True, threaded=True)
