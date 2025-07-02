import json
import re

def extract_json_from_markdown(markdown_string):
    # Remove the ```json and ``` code block
    cleaned = re.sub(r"^```json\s*|\s*```$", "", markdown_string.strip(), flags=re.DOTALL)

    # Fix unescaped control characters (e.g., real line breaks inside strings)
    cleaned = cleaned.replace('\n', '\\n').replace('\r', '\\r')

    # Now parse
    return json.loads(cleaned)

# Example use
raw_string = """```json
{
  "query": "SELECT * FROM users
WHERE age > 25",
  "valid": true
}
```"""

parsed = extract_json_from_markdown(raw_string)
print(parsed)
