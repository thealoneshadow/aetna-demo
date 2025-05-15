function extractBigQueries(inputText) {
  // Normalize the input by replacing line breaks with spaces
  const normalizedText = inputText.replace(/\n/g, ' ').replace(/\s+/g, ' ');

  // Match queries starting with SELECT and ending at the nearest semicolon or new SELECT (lookahead)
  const regex = /\bSELECT\b[\s\S]*?(?=(?:\bSELECT\b|$))/gi;

  // Extract matches
  const queries = [];
  let match;

  while ((match = regex.exec(normalizedText)) !== null) {
    const query = match[0].trim();
    if (query.length > 10) {
      queries.push(query);
    }
  }

  return queries;
}
