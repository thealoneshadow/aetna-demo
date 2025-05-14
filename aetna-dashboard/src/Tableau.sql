function splitAndCleanSQLQueries(rawSQL) {
  const queries = [];
  let current = '';
  let inSingleQuote = false;
  let inDoubleQuote = false;
  let inLineComment = false;
  let inBlockComment = false;

  for (let i = 0; i < rawSQL.length; i++) {
    const char = rawSQL[i];
    const nextChar = rawSQL[i + 1];

    // Line comments --
    if (!inSingleQuote && !inDoubleQuote && !inBlockComment && char === '-' && nextChar === '-') {
      inLineComment = true;
      i++;
      continue;
    }
    if (inLineComment && (char === '\n' || char === '\r')) {
      inLineComment = false;
      continue;
    }

    // Block comments /* ... */
    if (!inSingleQuote && !inDoubleQuote && !inLineComment && char === '/' && nextChar === '*') {
      inBlockComment = true;
      i++;
      continue;
    }
    if (inBlockComment && char === '*' && nextChar === '/') {
      inBlockComment = false;
      i++;
      continue;
    }

    if (inLineComment || inBlockComment) continue;

    // Quotes
    if (char === "'" && !inDoubleQuote) {
      inSingleQuote = !inSingleQuote;
    } else if (char === '"' && !inSingleQuote) {
      inDoubleQuote = !inDoubleQuote;
    }

    // Semicolon (safe split)
    if (char === ';' && !inSingleQuote && !inDoubleQuote) {
      if (current.trim()) {
        queries.push(current.trim());
      }
      current = '';
    } else {
      current += char;
    }
  }

  if (current.trim()) {
    queries.push(current.trim());
  }

  return queries.map(q => q.replace(/\s+/g, ' ').trim()); // Clean up whitespace
}
