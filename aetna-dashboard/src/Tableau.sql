

  {"question": "cool", "answer": "I'm not sure what information you're looking for with the word "cool". Can you please rephrase your query or tell me what you'd like to know?", "decision": "[Clarify]", "explanation": "The user query "cool" is vague and doesn't provide any context.  Clarification is needed to understand the user's intent.", "logId": "05bcf825-7b63-47b1-9816-36b80b6047df"}

{"question": "hi", "answer": "Hi there! How can I help you today?  I understand you're interested in leads, but could you please clarify your question? Are you interested in a specific aspect of leads, such as:  n n* The definition of a lead?  n* The different types of leads we have?  n* How leads are generated?  n* Lead performance during a specific time period?  n* Something else related to leads?  n nThe more details you can provide, the better I can assist you.", "decision": "Clarify", "explanation": "The user has only said "hi," which doesn't give me enough information to understand their needs. I'm asking clarifying questions to guide the conversation and provide a relevant response.", "assumptions": "None", "logId": "d66627dc-a018-4d78-adca-f81dbf7d71a3"}


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


