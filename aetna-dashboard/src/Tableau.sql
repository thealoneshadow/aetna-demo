

# dev_machine/api/main.py
from fastapi import FastAPI, Request
from pydantic import BaseModel
from vertexai.language_models import TextEmbeddingModel  # assumes you use Gemini embeddings
import uvicorn

app = FastAPI()

class EmbeddingRequest(BaseModel):
    texts: list[str]

@app.post("/get-embeddings")
def get_embeddings(req: EmbeddingRequest):
    model = TextEmbeddingModel.from_pretrained("textembedding-gecko@latest")
    embeddings = model.get_embeddings(req.texts)
    vectors = [e.values for e in embeddings]
    return {"embeddings": vectors}

if _name_ == "_main_":
    uvicorn.run(app, host="0.0.0.0", port=8000)

##### on test machine
import requests
from langchain.vectorstores import FAISS
from langchain.docstore.document import Document
from langchain.embeddings.base import Embeddings

# Custom wrapper to use remote embeddings
class RemoteEmbedding(Embeddings):
    def _init_(self, api_url):
        self.api_url = api_url

    def embed_documents(self, texts):
        res = requests.post(f"{self.api_url}/get-embeddings", json={"texts": texts})
        return res.json()["embeddings"]

    def embed_query(self, text):
        return self.embed_documents([text])[0]

# Set this to your dev machine's IP
REMOTE_API_URL = "http://<dev-machine-ip>:8000"
embedding = RemoteEmbedding(api_url=REMOTE_API_URL)

# Example: Creating FAISS DB
documents = [Document(page_content="LangChain is amazing."), Document(page_content="Vertex AI provides embeddings.")]
texts = [doc.page_content for doc in documents]
faiss_index = FAISS.from_texts(texts, embedding)

# Example: Querying FAISS DB
query = "What is Vertex AI?"
results = faiss_index.similarity_search(query)
for r in results:
    print(r.page_content)




      














   <button
        onClick={scrollToTop}
        style={{
          position: "absolute",
          right: "10px",
          top: "10px",
          backgroundColor: "#fff",
          border: "1px solid #ccc",
          borderRadius: "50%",
          padding: "6px 10px",
          cursor: "pointer",
          boxShadow: "0 2px 6px rgba(0,0,0,0.1)",
        }}
      >
        ⬆️
      </button>

      <button
        onClick={scrollToBottom}
        style={{
          position: "absolute",
          right: "10px",
          bottom: "10px",
          backgroundColor: "#fff",
          border: "1px solid #ccc",
          borderRadius: "50%",
          padding: "6px 10px",
          cursor: "pointer",
          boxShadow: "0 2px 6px rgba(0,0,0,0.1)",
        }}
      >
        ⬇️
      </button>


    .scroll-buttons {
      margin-top: 10px;
      display: flex;
      gap: 10px;
    }

    .scroll-buttons button {
      padding: 8px 12px;
      font-size: 16px;
      cursor: pointer;
    }
