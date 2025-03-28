const extractSQLQuery = (text) => {
  // Regex pattern to capture SQL code inside triple backticks (```) or within SQL keywords
  const regex = /```sql([\s\S]*?)```|SELECT[\s\S]*?;/gi;
  const matches = text.match(regex);
  return matches ? matches[0].trim() : "No SQL query found";
};






