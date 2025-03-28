const extractSQLQuery = (text) => {
  // Regex pattern to capture SQL inside triple backticks or standalone queries
  const regex = /```sql([\s\S]*?)```|SELECT[\s\S]*?;/gi;
  const matches = text.match(regex);

  if (!matches) return "No SQL query found";

  let cleanedSQL = matches[0]
    .replace(/```sql/g, "") // Remove ```sql
    .replace(/```/g, "") // Remove ```
    .replace(/\s+/g, " ") // Replace multiple spaces & newlines with a single space
    .trim(); // Remove leading/trailing spaces

  return cleanedSQL;
};
