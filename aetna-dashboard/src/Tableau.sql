import google.generativeai as genai

# No need to manually configure API key
genai.configure()

# Initialize the Gemini model
model = genai.GenerativeModel("gemini-pro")

def generate_sql_gemini(question):
    prompt = f"Given this database schema information:\n{answer}\nGenerate an SQL query for: {question}"
    
    response = model.generate_content(prompt)  
    
    return response.text  # Gemini returns text output

# Example Usage
sql_query = generate_sql_gemini("List all user emails")
print("Generated SQL Query:\n", sql_query)






