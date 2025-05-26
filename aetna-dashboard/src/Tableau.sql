function extractBigQueries(inputText) {
  // Normalize the input by replacing line breaks with spaces
  const normalizedText = inputText.replace(/\n/g, ' ').replace(/\s+/g, ' ');

  // Match queries starting with SELECT and ending at the nearest semicolon or new SELECT (lookahead)
  const regex = /\bSELECT\b[\s\S]*?(?=(?:\bSELECT\b|$))/gi;

  // Extract matches
  const queries = [];
  let match;

  while ((match = regex.exec(normalizedText)) !== null) {
    const query = match[0].trim();
    if (query.length > 10) {
      queries.push(query);
    }
  }

  return queries;
}

Valid months for the AEP period are October , November, and December

Rephrase by aggregating calls and grouping by lead type, exclude not applicable for lead type. Not applicable is not a valid lead _type




from flask import Flask, jsonify
from google.cloud import bigquery

app = Flask(__name__)

@app.route('/run-procedure')
def run_bigquery_procedure():
    try:
        client = bigquery.Client()

        # Call the stored procedure
        query = "CALL `my_project.my_dataset.get_users`()"
        job = client.query(query)

        # Fetch results
        results = [dict(row) for row in job.result()]
        return jsonify(results)

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

