function extractBigQueries(text) {
  const queries = [];
  const lines = text.split(/\r?\n/);

  let currentQuery = '';
  let insideQuery = false;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i].trim();

    // Skip empty or comment lines
    if (!line || line.startsWith('--')) continue;

    // Start of a new query
    if (/^SELECT\b/i.test(line)) {
      // Save the previous query if any
      if (currentQuery.trim()) {
        queries.push(currentQuery.trim());
        currentQuery = '';
      }
      insideQuery = true;
    }

    // Append the line if inside a query
    if (insideQuery) {
      currentQuery += (currentQuery ? ' ' : '') + line;

      // If next line is not SELECT and this is the last line
      const nextLine = lines[i + 1]?.trim() || '';
      if (!/^SELECT\b/i.test(nextLine) && i + 1 === lines.length - 1) {
        queries.push(currentQuery.trim());
        currentQuery = '';
      }
    }
  }

  // Push last one if any
  if (currentQuery.trim()) {
    queries.push(currentQuery.trim());
  }

  return queries;
}
