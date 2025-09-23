function extractValue(str) {
  let regexIssue = /\(BOP_MEMBERSHIP_ISSUE\)\s*>\s*(\d+)/;
  let regexMembership = /\(BOP_MEMBERSHIP\)\s*>\s*(\d+)/;

  // Check for ISSUE first
  let match = str.match(regexIssue);
  if (match) {
    return parseInt(match[1], 10);
  }

  // Fallback to MEMBERSHIP
  match = str.match(regexMembership);
  if (match) {
    return parseInt(match[1], 10);
  }

  return null; // nothing found
}

// Examples
console.log(extractValue("(BOP_MEMBERSHIP_ISSUE) > 500")); // 500
console.log(extractValue("(BOP_MEMBERSHIP) > 300"));       // 300
console.log(extractValue("RANDOM_TEXT > 200"));            // null
