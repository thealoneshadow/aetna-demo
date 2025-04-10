

  {"question": "cool", "answer": "I'm not sure what information you're looking for with the word "cool". Can you please rephrase your query or tell me what you'd like to know?", "decision": "[Clarify]", "explanation": "The user query "cool" is vague and doesn't provide any context.  Clarification is needed to understand the user's intent.", "logId": "05bcf825-7b63-47b1-9816-36b80b6047df"}

{"question": "hi", "answer": "Hi there! How can I help you today?  I understand you're interested in leads, but could you please clarify your question? Are you interested in a specific aspect of leads, such as:  n n* The definition of a lead?  n* The different types of leads we have?  n* How leads are generated?  n* Lead performance during a specific time period?  n* Something else related to leads?  n nThe more details you can provide, the better I can assist you.", "decision": "Clarify", "explanation": "The user has only said "hi," which doesn't give me enough information to understand their needs. I'm asking clarifying questions to guide the conversation and provide a relevant response.", "assumptions": "None", "logId": "d66627dc-a018-4d78-adca-f81dbf7d71a3"}


    {"question": "cool", "answer": "I'm not sure what information you're looking for with the word "cool". Can you please rephrase your query or tell me what you'd like to know?", "decision": "[Clarify]", "explanation": "The user query "cool" is vague and doesn't provide any context.  Clarification is needed to understand the user's intent.", "logId": "05bcf825-7b63-47b1-9816-36b80b6047df"}



    function fixMalformedJsonString(str) {
  // 1. Escape inner quotes in values
  const escaped = str.replace(/:\s*"((?:[^"\\]|\\.)*?)"/g, (match, p1) => {
    const escapedValue = p1.replace(/"/g, '\\"');
    return `: "${escapedValue}"`;
  });

  // 2. Remove quotes around keys
  const unquotedKeys = escaped.replace(/"(\w+)"\s*:/g, '$1:');

  return unquotedKeys;
}

const brokenJson = `{"question": "cool", "answer": "I'm not sure what information you're looking for with the word "cool". Can you please rephrase?"}`;

const fixed = fixMalformedJsonString(brokenJson);

console.log(fixed);

    
function safelyFixMalformedJSON(badJsonString) {
  // Step 1: Fix quotes around values like "cool" inside other strings
  // We'll replace "value with "inner" quotes" to escaped inner quotes
  const fixed = badJsonString.replace(/"([^"]*?)"(?=:)/g, (match) => {
    // Keep this as-is — it's the keys
    return match;
  }).replace(/:\s*"((?:[^"\\]|\\.)*?)"(?=[,\}])/g, (match, value) => {
    const escapedValue = value.replace(/"/g, '\\"'); // Escape inner quotes
    return `: "${escapedValue}"`;
  });



     return input.replace(/:\s*"((?:[^"\\]|\\.)*)"/g, (match, value) => {
    const escapedValue = value.replace(/(?<!\\)"/g, '\\"');
    return `: "${escapedValue}"`;
  });

    badJSON.replace(/:\s*"([^"]*?)"([^,}\]])/g, (match, p1, p2) => {
      // Escape quotes inside the value
      const escaped = p1.replace(/"/g, '\\"');
      return `: "${escaped}"${p2}`;
    });
    
   const keysToPreserve = ['question', 'answer', 'assumptions', 'explanation', 'logId', 'decision'];

  return input.replace(/"(\w+)":\s*"([^"]*?)"/g, (match, key, value) => {
    if (keysToPreserve.includes(key)) {
      // Escape quotes inside the value ONLY if it's not already escaped
      const escapedValue = value.replace(/(?<!\\)"/g, '\\"');
      return `"${key}": "${escapedValue}"`;
    } else {
      return match; // Leave other parts untouched
    }
  });

    function escapeInnerQuotes(jsonStr) {
  let insideString = false;
  let escaped = false;
  let result = '';
  
  for (let i = 0; i < jsonStr.length; i++) {
    const char = jsonStr[i];

    if (char === '"' && !escaped) {
      // toggle if entering or exiting a string
      insideString = !insideString;
      result += char;
    } else if (char === '"' && insideString && !escaped) {
      // this is an unescaped quote inside a string → escape it
      result += '\\"';
    } else {
      result += char;
    }

    // track escape character
    escaped = char === '\\' && !escaped;
  }

  return result;
}



