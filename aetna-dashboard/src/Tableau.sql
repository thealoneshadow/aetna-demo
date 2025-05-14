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

    // Detect line comment --
    if (!inSingleQuote && !inDoubleQuote && !inBlockComment && char === '-' && nextChar === '-') {
      inLineComment = true;
      i++; // skip nextChar to avoid adding --
      continue;
    }

    // End of line comment
    if (inLineComment && (char === '\n' || char === '\r')) {
      inLineComment = false;
      continue;
    }

    // Detect block comment /*
    if (!inSingleQuote && !inDoubleQuote && !inLineComment && char === '/' && nextChar === '*') {
      inBlockComment = true;
      i++; // skip nextChar to avoid adding /*
      continue;
    }

    // End of block comment */
    if (inBlockComment && char === '*' && nextChar === '/') {
      inBlockComment = false;
      i++; // skip nextChar
      continue;
    }

    // Skip characters inside comments
    if (inLineComment || inBlockComment) {
      continue;
    }

    // Toggle quotes
    if (char === "'" && !inDoubleQuote) {
      inSingleQuote = !inSingleQuote;
    } else if (char === '"' && !inSingleQuote) {
      inDoubleQuote = !inDoubleQuote;
    }

    // Parentheses tracking
    if (!inSingleQuote && !inDoubleQuote) {
      if (char === '(') parenthesesDepth++;
      if (char === ')') parenthesesDepth--;
    }

    // Semicolon at top level = query separator
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
