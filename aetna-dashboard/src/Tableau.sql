const membershipMatch = query.match(/membership\s*(>=|<=|=|>|<)\s*(\d+)/i);

// Match LIMIT value
const limitMatch = query.match(/LIMIT\s+(\d+)/i);

// Extract values
const membershipValue = membershipMatch ? parseInt(membershipMatch[2], 10) : null;
const limitValue = limitMatch ? parseInt(limitMatch[1], 10) : null;
