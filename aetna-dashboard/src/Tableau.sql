const extractColumnNames = (sql) => {
  // Extract the SELECT clause before FROM
  const match = sql.match(/SELECT([\s\S]*?)FROM/i);
  if (!match || match.length < 2) return [];

  const selectClause = match[1];

  return selectClause
    .split(/,(?![^()]*\))/) // Split by commas, but ignore commas inside parentheses
    .map((col) => {
      col = col.trim(); // Remove spaces

      // Extract alias if present
      const aliasMatch = col.match(/AS\s+["']?(\w+)["']?/i);
      if (aliasMatch) return aliasMatch[1].trim(); // Return alias if found

      // Handle cases where there's no alias
      const cleanedCol = col
        .replace(/COUNT\s*\(.*?\)|SUM\s*\(.*?\)|AVG\s*\(.*?\)|MIN\s*\(.*?\)|MAX\s*\(.*?\)/gi, "") // Remove aggregate functions
        .replace(/CASE\s+WHEN[\s\S]*?END/i, "") // Remove CASE WHEN statements
        .trim();

      // Extract the last valid part (handles expressions like "table.column AS alias")
      const parts = cleanedCol.split(/\s+/);
      return parts[parts.length - 1]; // Return last meaningful word
    })
    .filter(Boolean); // Remove empty values
};



ELECT 
    calendar_year, 
    COUNT(answered_call) AS total_answered_calls, 
    ( 
      COUNT(answered_call) - LAG(COUNT(answered_call), 1, 0) OVER (ORDER BY calendar_year) 
    ) * 100.0 / LAG(COUNT(answered_call), 1, 1) OVER (ORDER BY calendar_year) AS yoy_growth 
  FROM 
    `anbc-hcb-prod.msa_share_mcr_hcb_prod.MMPD_CONSUMPTION_CURR_PREV_AEP` 
  WHERE answered_call IS NOT NULL 
  GROUP BY 1 
ORDER BY 
  calendar_year; 
