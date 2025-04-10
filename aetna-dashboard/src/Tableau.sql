

  {"question": "cool", "answer": "I'm not sure what information you're looking for with the word "cool". Can you please rephrase your query or tell me what you'd like to know?", "decision": "[Clarify]", "explanation": "The user query "cool" is vague and doesn't provide any context.  Clarification is needed to understand the user's intent.", "logId": "05bcf825-7b63-47b1-9816-36b80b6047df"}



  function fixBrokenJson(input) {
  // Regex: finds quotes inside string values that aren't escaped
  return input.replace(/:\s*"((?:[^"\\]|\\.)*)"/g, (match, value) => {
    // Escape unescaped double quotes inside the value
    const escaped = value.replace(/(?<!\\)"/g, '\\"');
    return `: "${escaped}"`;
  });
}
-----------------------------


