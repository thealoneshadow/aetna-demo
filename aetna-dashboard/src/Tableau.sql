function splitSQLQueries(sqlString) {
  const queries = [];
  let currentQuery = '';
  let inSingleQuote = false;
  let inDoubleQuote = false;
  let inLineComment = false;
  let inBlockComment = false;
  let parenthesesDepth = 0;

  for (let i = 0; i < sqlString.length; i++) {
    const char = sqlString[i];
    const nextChar = sqlString[i + 1];

    // Start of -- comment
    if (!inSingleQuote && !inDoubleQuote && !inBlockComment && char === '-' && nextChar === '-') {
      inLineComment = true;
      i++; // skip nextChar
      continue;
    }

    // End of line comment
    if (inLineComment && (char === '\n' || char === '\r')) {
      inLineComment = false;
      continue;
    }

    // Start of block comment /*
    if (!inSingleQuote && !inDoubleQuote && !inLineComment && char === '/' && nextChar === '*') {
      inBlockComment = true;
      i++; // skip nextChar
      continue;
    }

    // End of block comment */
    if (inBlockComment && char === '*' && nextChar === '/') {
      inBlockComment = false;
      i++; // skip nextChar
      continue;
    }

    // Skip anything inside comments
    if (inLineComment || inBlockComment) {
      continue;
    }

    // Toggle quote flags
    if (char === "'" && !inDoubleQuote) {
      inSingleQuote = !inSingleQuote;
    } else if (char === '"' && !inSingleQuote) {
      inDoubleQuote = !inDoubleQuote;
    }

    // Track parentheses
    if (!inSingleQuote && !inDoubleQuote) {
      if (char === '(') parenthesesDepth++;
      if (char === ')') parenthesesDepth--;
    }

    // Split at top-level semicolon
    if (char === ';' && !inSingleQuote && !inDoubleQuote && parenthesesDepth === 0) {
      if (currentQuery.trim()) {
        queries.push(currentQuery.trim());
      }
      currentQuery = '';
    } else {
      currentQuery += char;
    }
  }

  if (currentQuery.trim()) {
    queries.push(currentQuery.trim());
  }

  return queries;
}
