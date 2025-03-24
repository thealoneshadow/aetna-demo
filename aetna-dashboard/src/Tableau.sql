!pip install pandas openpyxl google-cloud-aiplatform sentence-transformers faiss-cpu



import pandas as pd

# Load the Excel file
file_path = "TestModel.xlsx"
df = pd.read_excel(file_path)

# Display first few rows
print(df.head())




data = []
for _, row in df.iterrows():
    text = " | ".join(str(value) for value in row.values)  # Combine all columns into a single text entry
    data.append(text)

print(f"Total records for embedding: {len(data)}")


from sentence_transformers import SentenceTransformer

# Load embedding model
model = SentenceTransformer("all-MiniLM-L6-v2")  # Efficient and accurate

# Generate embeddings
embeddings = model.encode(data)

print("Generated vector embeddings shape:", embeddings.shape)


import faiss
import numpy as np

# Convert embeddings to FAISS index
dimension = embeddings.shape[1]
index = faiss.IndexFlatL2(dimension)  # L2 similarity search
index.add(np.array(embeddings))

print("FAISS index created with embeddings!")




def search_answer(question):
    question_embedding = model.encode([question])
    _, indices = index.search(np.array(question_embedding), k=1)  # Get top match

    matched_text = data[indices[0][0]]
    return matched_text

# Example query
question = "What is the primary key of the users table?"
answer = search_answer(question)

print("Answer:", answer)


!pip install google-cloud-aiplatform google-generativeai



from google.cloud import aiplatform

# Initialize Vertex AI with your current GCP project
aiplatform.init(project="singular-chain-454407-t8", location="us-central1")





