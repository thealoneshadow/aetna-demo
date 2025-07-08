function extractJsonObjects(rawString) {
  // Step 1: Clean up invalid characters (e.g., I", |, etc.)
  const cleaned = rawString
    .replace(/[|`\\n\\r]/g, "")             // remove | ` \n \r
    .replace(/I"?/g, '"')                   // replace I" or I with "
    .replace(/([a-zA-Z0-9])"([a-zA-Z0-9])/g, '$1:$2') // ensure colons stay correct
    .replace(/([a-zA-Z0-9])"([,}])/g, '$1"$2');       // close keys properly

  // Step 2: Extract JSON objects with regex
  const matches = cleaned.match(/{[^}]*}/g);

  if (!matches) return [];

  // Step 3: Parse each JSON safely
  return matches
    .map((str) => {
      try {
        return JSON.parse(str);
      } catch (err) {
        console.warn("Invalid JSON skipped:", str);
        return null;
      }
    })
    .filter(Boolean); // remove nulls
}


.replace(/[|`]/g, "")           // remove pipe and backtick
    .replace(/\n/g, "")             // remove newlines
    .replace(/\r/g, "")             // remove carriage returns
    .replace(/I"?/g, '"')           // replace I" or I with "
    .replace(/([a-zA-Z0-9])"([a-zA-Z0-9])/g, '$1:$2') // fix missing colons
    .replace(/([a-zA-Z0-9])"([,}])/g, '$1"$2'); 
