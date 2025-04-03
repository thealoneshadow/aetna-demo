const extractColumnNames = (sql) => {
  const match = sql.match(/SELECT([\s\S]*?)FROM/i); // Match SELECT part until FROM
  if (!match || match.length < 2) return [];

  return match[1]
    .split(",") // Split by comma (handles basic cases)
    .map((col) => {
      col = col.trim(); // Remove spaces

      // Capture alias if present (supports "AS alias" and "AS 'alias name'")
      const aliasMatch = col.match(/AS\s+["']?(\w+)["']?/i);
      if (aliasMatch) return aliasMatch[1].trim(); // Return alias

      // Remove function calls, case expressions, and extract first valid column name
      return col
        .replace(/\(.*?\)/g, "") // Remove function parentheses
        .replace(/CASE\s+WHEN[\s\S]*?END/i, "") // Remove CASE WHEN statements
        .trim()
        .split(" ")[0]; // Extract first word
    })
    .filter(Boolean); // Remove empty values
};
