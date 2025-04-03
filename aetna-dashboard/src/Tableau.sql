const extractColumnNames = (sql) => {
  const match = sql.match(/SELECT([\s\S]*?)FROM/i); // Match SELECT until FROM
  if (!match || match.length < 2) return [];

  const selectPart = match[1].trim(); // Extract the columns part
  const columns = [];
  
  // Regex to extract column names with aliases
  const regex = /(?:COUNT|SUM|AVG|MIN|MAX|CASE|IF|DISTINCT|\w+\(.*?\))?\s*(?:\((.*?)\))?\s*(?:AS\s+["']?(\w+)["']?)?/gi;
  
  let columnMatches;
  while ((columnMatches = regex.exec(selectPart)) !== null) {
    const [, expression, alias] = columnMatches;

    if (alias) {
      columns.push(alias); // Use alias if available
    } else if (expression) {
      columns.push(expression.split(" ")[0]); // Extract first word (function-safe)
    }
  }

  return columns.filter(Boolean); // Remove empty values
};
