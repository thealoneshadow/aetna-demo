const extractColumnNames = (sql) => {
  // Extract the SELECT clause before FROM
  const match = sql.match(/SELECT([\s\S]*?)FROM/i);
  if (!match || match.length < 2) return [];

  let selectClause = match[1].trim();

  // Handle case where only one column is selected (no commas)
  if (!selectClause.includes(",")) selectClause = [selectClause];
  else selectClause = selectClause.split(/,(?![^()]*\))/); // Split by commas, ignoring those inside parentheses

  return selectClause
    .map((col) => {
      col = col.trim(); // Remove spaces

      // Extract alias if present (handles AS "alias" and AS alias)
      const aliasMatch = col.match(/AS\s+["']?(\w+)["']?/i);
      if (aliasMatch) return aliasMatch[1].trim(); // Use alias if found

      // Remove function calls (COUNT(), LAG(), etc.) but keep column references
      const cleanedCol = col
        .replace(/LAG\s*\(.*?\)|LEAD\s*\(.*?\)|COUNT\s*\(.*?\)|SUM\s*\(.*?\)|AVG\s*\(.*?\)|MIN\s*\(.*?\)|MAX\s*\(.*?\)/gi, "") // Remove functions
        .replace(/CASE\s+WHEN[\s\S]*?END/i, "") // Remove CASE WHEN expressions
        .replace(/\*|\+|\-|\/|\(|\)/g, " ") // Replace mathematical operators with spaces
        .trim();

      // Extract the last meaningful word (handles "table.column AS alias")
      const parts = cleanedCol.split(/\s+/);
      return parts[parts.length - 1]; // Return last valid column part
    })
    .filter(Boolean); // Remove empty values
};



    const extractColumnNames = (sql) => {
  // Extract the SELECT clause before FROM
  const match = sql.match(/SELECT([\s\S]*?)FROM/i);
  if (!match || match.length < 2) return [];

  let selectClause = match[1].trim();

  // Handle single-column queries without commas
  const columns = selectClause.includes(",")
    ? selectClause.split(/,(?![^()]*\))/) // Split by commas, ignoring those inside parentheses
    : [selectClause];

  return columns
    .map((col) => {
      col = col.trim(); // Remove spaces

      // Extract alias if present (handles AS "alias" and AS alias)
      const aliasMatch = col.match(/AS\s+["']?(\w+)["']?/i);
      if (aliasMatch) return aliasMatch[1].trim(); // Use alias if found

      // Extract column name from aggregate functions (COUNT(), SUM(), etc.)
      const functionMatch = col.match(/\((.*?)\)/);
      if (functionMatch) return functionMatch[1].trim(); // Extract column inside COUNT(), SUM(), etc.

      return col; // Return cleaned column name
    })
    .filter(Boolean); // Remove empty values
};
