function extractBigQueries(text) {
  const regex = /(?=SELECT\b)[\s\S]*?(?=(?=SELECT\b)|$)/gi;
  const matches = text.match(regex) || [];

  // Clean each match by trimming and collapsing whitespace
  return matches.map(q => q.trim().replace(/\s+/g, ' ')).filter(q => q.length > 0);
}
