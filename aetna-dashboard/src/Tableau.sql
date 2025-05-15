function extractBigQueryStatements(text) {
  const queries = [];
  let current = '';
  let inSingleQuote = false;
  let inLineComment = false;
  let inBlockComment = false;

  for (let i = 0; i < text.length; i++) {
    const char = text[i];
    const nextChar = text[i + 1];

    // Start of line comment --
    if (!inSingleQuote && !inLineComment && !inBlockComment && char === '-' && nextChar === '-') {
      inLineComment = true;
      i++; // Skip nextChar
      continue;
    }

    // End of line comment
    if (inLineComment && (char === '\n' || char === '\r')) {
      inLineComment = false;
      continue;
    }

    // Inside line comment, skip characters
    if (inLineComment) continue;

    // Start of block comment /*
    if (!inSingleQuote && !inBlockComment && char === '/' && nextChar === '*') {
      inBlockComment = true;
      i++; // Skip *
      continue;
    }

    // End of block comment */
    if (inBlockComment && char === '*' && nextChar === '/') {
      inBlockComment = false;
      i++; // Skip /
      continue;
    }

    // Inside block comment, skip characters
    if (inBlockComment) continue;

    // Toggle single quote
    if (char === "'") {
      inSingleQuote = !inSingleQuote;
    }

    // Semicolon ends a statement (outside quotes)
    if (char === ';' && !inSingleQuote) {
      if (current.trim()) {
        queries.push(current.trim());
      }
      current = '';
    } else {
      current += char;
    }
  }

  // Push last query if not terminated with semicolon
  if (current.trim()) {
    queries.push(current.trim());
  }

  return queries;
}
