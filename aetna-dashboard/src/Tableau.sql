from flask import Flask, request, jsonify
from vertexai.language_models import TextEmbeddingModel
import vertexai

app = Flask(_name_)

# Initialize Vertex AI
vertexai.init(
        project="bigquerytrainingproject-451817",
        location="us-central1",
        api_endpoint="us-central1-aiplatform.googleapis.com"
)

# Load the embedding model
embedding_model = TextEmbeddingModel.from_pretrained("text-embedding-004")

@app.route('/embed_text', methods=['POST'])
def embed_text():
    data = request.get_json()
    if not data or 'text' not in data:
        return jsonify({"error": "Missing 'text' in request"}), 400

    try:
        text = data['text']
        response = embedding_model.get_embeddings([text])
        embedding = response[0].values
        return jsonify({"embedding": embedding})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/embed_documents', methods=['POST'])
def embed_documents():
    data = request.get_json()
    if not data or 'texts' not in data or not isinstance(data['texts'], list):
        return jsonify({"error": "Missing or invalid 'texts' in request"}), 400

    try:
        texts = data['texts']
        response = embedding_model.get_embeddings(texts)
        embeddings = [r.values for r in response]
        return jsonify({"embeddings": embeddings})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if _name_ == '_main_':
    app.run(host='127.0.0.1', port=5000, debug=True)


use it in local:

# test_machine_embedder.py

import requests
from langchain.embeddings.base import Embeddings

class RemoteAPIEmbeddings(Embeddings):
    def _init_(self, api_url: str):
        self.api_url = api_url.rstrip("/")  # Clean URL

    def embed_documents(self, texts):
        response = requests.post(f"{self.api_url}/embed_documents", json={"texts": texts})
        response.raise_for_status()
        return response.json()["embeddings"]

    def embed_query(self, text):
        response = requests.post(f"{self.api_url}/embed_text", json={"text": text})
        response.raise_for_status()
        return response.json()["embedding"]


# build_faiss.py

from langchain.vectorstores import FAISS
from langchain.docstore.document import Document
# Local file from step 1

# Set your dev machine's IP here
embedding = RemoteAPIEmbeddings("http://127.0.0.1:5000")  # Change IP

docs = [
    Document(page_content="LangChain helps with LLM apps."),
    Document(page_content="FAISS is used for similarity search."),
    Document(page_content="Vertex AI provides cloud AI services."),
]

# Create FAISS vector store
db = FAISS.from_documents(docs, embedding)
# db.save_local("faiss_index")  # Store on disk

# breakpoint()
# query_faiss.py

from langchain.vectorstores import FAISS


# Load vector store
embedding = RemoteAPIEmbeddings("http://127.0.0.1:5000")  # Same dev machine IP
# db = FAISS.load_local("faiss_index", embeddings=embedding)

query = "What does FAISS do?"
results = db.similarity_search(query,k=1)

for i, doc in enumerate(results, start=1):
    print(f"{i}. {doc.page_content}")
