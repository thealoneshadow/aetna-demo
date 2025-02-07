 results = query_job.result()  # Fetch results
    rows = [dict(row) for row in results]  # Convert Row objects to dictionaries

    # ✅ Convert to DataFrame (without db-dtypes)
    df = pd.DataFrame(rows)

    # ✅ Write CSV using Pandas
    output = io.StringIO()
    df.to_csv(output, index=False)

    output.seek(0)
