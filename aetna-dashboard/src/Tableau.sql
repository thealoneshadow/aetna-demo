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

    // Handle -- line comment
    if (!inSingleQuote && !inDoubleQuote && !inBlockComment && char === '-' && nextChar === '-') {
      inLineComment = true;
    }

    // End of line comment
    if (inLineComment && (char === '\n' || char === '\r')) {
      inLineComment = false;
    }

    // Handle /* block comment */
    if (!inSingleQuote && !inDoubleQuote && !inLineComment && char === '/' && nextChar === '*') {
      inBlockComment = true;
    }

    // End of block comment */
    if (inBlockComment && char === '*' && nextChar === '/') {
      inBlockComment = false;
      currentQuery += '*/'; // include end of comment
      i++;
      continue;
    }

    // Ignore characters inside comments
    if (inLineComment || inBlockComment) {
      currentQuery += char;
      continue;
    }

    // Handle quote toggling
    if (char === "'" && !inDoubleQuote) {
      inSingleQuote = !inSingleQuote;
    } else if (char === '"' && !inSingleQuote) {
      inDoubleQuote = !inDoubleQuote;
    }

    // Track parentheses depth (used in functions, subqueries)
    if (!inSingleQuote && !inDoubleQuote) {
      if (char === '(') parenthesesDepth++;
      if (char === ')') parenthesesDepth--;
    }

    // Detect query delimiter (;) safely
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
