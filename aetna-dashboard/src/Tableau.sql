const extractColumnNames = (sql) => {
  const match = sql.match(/SELECT (.*?) FROM/i); // Extract everything between SELECT and FROM
  if (!match || match.length < 2) return [];

  const columns = match[1]
    .split(",") // Split columns by comma
    .map(col => col.trim().split(" ")[0]) // Remove alias (AS) and extra spaces
    .filter(col => col !== "*"); // Ignore "*" (if present)

  return columns;
};
