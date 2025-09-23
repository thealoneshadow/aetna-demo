function extractValue(str) {
  // Regex for ISSUE first (either (BOP_MEMBERSHIP_ISSUE) or SUM(T.BOP_MEMBERSHIP_ISSUE))
  let regexIssue = /\b(?:SUM\s*\(T\.\s*BOP_MEMBERSHIP_ISSUE\)|\(BOP_MEMBERSHIP_ISSUE\))\s*>\s*(\d+)/i;

  // Regex for MEMBERSHIP
  let regexMembership = /\b(?:SUM\s*\(T\.\s*BOP_MEMBERSHIP\)|\(BOP_MEMBERSHIP\))\s*>\s*(\d+)/i;

  // Priority: ISSUE first
  let match = str.match(regexIssue);
  if (match) {
    return parseInt(match[1], 10);
  }

  // Fallback: MEMBERSHIP
  match = str.match(regexMembership);
  if (match) {
    return parseInt(match[1], 10);
  }

  return null; // nothing found
}
