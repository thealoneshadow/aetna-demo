const extractColumnNames = (sql) => {
  const match = sql.match(/SELECT (.*?) FROM/i);
  if (!match || match.length < 2) return [];

  return match[1]
    .split(",") // Split columns by comma
    .map((col) => {
      const aliasMatch = col.match(/AS\s+(\w+)/i); // Capture alias if present
      if (aliasMatch) return aliasMatch[1].trim(); // Return alias if found

      return col.replace(/\(.*?\)/g, "").trim().split(" ")[0]; // Remove function calls & trim
    });
};
