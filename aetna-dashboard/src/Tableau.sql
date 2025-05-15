function extractBigQueryStatements(rawText) {
  // Clean up common junk first
  const normalizedText = rawText
    .replace(/\n/g, ' ')               // Convert all newlines to spaces
    .replace(/\s+/g, ' ')              // Collapse multiple spaces
    .replace(/["“”]/g, '"')            // Normalize quotes
    .replace(/[‘’]/g, "'")             // Normalize single quotes
    .trim();

  const queries = [];
  let buffer = '';
  let inSingleQuote = false;
  let inDoubleQuote = false;

  for (let i = 0; i < normalizedText.length; i++) {
    const char = normalizedText[i];
    const nextChar = normalizedText[i + 1];

    // Toggle quote states
    if (char === "'" && !inDoubleQuote) inSingleQuote = !inSingleQuote;
    if (char === '"' && !inSingleQuote) inDoubleQuote = !inDoubleQuote;

    // Add char to buffer
    buffer += char;

    // Only split if outside quotes
    if ((char === ';' || (char.toUpperCase() === 'S' && normalizedText.slice(i, i + 6).toUpperCase() === 'SELECT'))
        && !inSingleQuote && !inDoubleQuote && buffer.trim().toUpperCase().endsWith('SELECT')) {
      // Push previous if exists
      if (buffer.trim()) {
        const maybeQuery = buffer.trim().replace(/^SELECT/i, ''); // remove SELECT from start
        if (maybeQuery) queries.push('SELECT' + maybeQuery);
      }
      buffer = '';
    }
  }

  // Add any remaining query
  if (buffer.trim()) {
    queries.push(buffer.trim());
  }

  return queries;
}
