import json
import re
import uuid
from urllib.parse import unquote
from werkzeug.exceptions import Unauthorized
from flask import jsonify, request, render_template, redirect, make_response
import sys
from .blueprints import module_blueprints
from langgraph.graph import StateGraph , END

from langchain_community.vectorstores import FAISS
from langchain.tools import tool
import pandas as pd
import os
 
from typing_extensions import TypedDict , Optional
 
from langchain_core.documents import Document
from langchain_core.outputs import LLMResult, Generation
from vertexai.language_models import TextEmbedding

 
from google.cloud import aiplatform
import vertexai
from vertexai.generative_models import GenerativeModel, Part, SafetySetting, FinishReason

from vertexai.language_models import TextEmbeddingModel
from langgraph.graph import StateGraph, END
from langchain_core.language_models import BaseLLM
from langchain_core.embeddings import Embeddings
from langchain_core.callbacks import CallbackManagerForLLMRun
from langchain_core.outputs import LLMResult, Generation
from typing import Any , List   , Optional, Dict, Union
from langchain_community.vectorstores import FAISS 
import google.auth 
from google.cloud  import aiplatform


base_dir = os.path.dirname(os.path.abspath("BRDTest.txt"))
path = os.path.join(base_dir, "BRDTest.txt")

myproject="anbc-dev-growth-anlyt",
mylocation="us-central1",
myapi_endpoint="us-central1-aiplatform.googleapis.com"
default_timing = "AEP2025"
latest_aep = "AEP2025"
pre_aep = "AEP2024"

def get_formated_history(history):
        recent_history = history
        print(recent_history)
        return "\n".join([f"{msg['role']}:{msg['content']}" for msg in recent_history])

def chunk_text(text, chunk_size =100, overlap = 15):
        words = text.split()
        chunks = []
        for i in range(0,len(words), chunk_size - overlap): # type: ignore
            chunk = " ".join(words[i:i+chunk_size])
            chunks.append(chunk)
        
        return chunks

class CustomVertexAILLM(BaseLLM):
    generation_config: Dict = {
        # "max_output_tokens": 8192,
        "temperature":0,
        "top_p": 0.95,
        "seed":0
    }

    safety_settings: List[SafetySetting] = [

        SafetySetting(category = "HARM_CATEGORY_HATE_SPEECH",threshold = "BLOCK_MEDIUM_AND_ABOVE"), # type: ignore

        SafetySetting(category = "HARM_CATEGORY_DANGEROUS_CONTENT",threshold = "BLOCK_MEDIUM_AND_ABOVE"), # type: ignore

        SafetySetting(category = "HARM_CATEGORY_SEXUALLY_EXPLICIT",threshold = "BLOCK_MEDIUM_AND_ABOVE"), # type: ignore

        SafetySetting(category = "HARM_CATEGORY_HARASSMENT",threshold = "BLOCK_MEDIUM_AND_ABOVE") # type: ignore

    ]
 

    def _generate(
        self,
        prompts: List[str],
        stop: Optional[List[str]] = None,
        run_manager: Optional[CallbackManagerForLLMRun] = None,
        **kwargs: Any,
        ) -> LLMResult:
        vertexai.init(
        project="anbc-dev-growth-anlyt",
        location="us-central1",
        api_endpoint="us-central1-aiplatform.googleapis.com"
        )
        model = GenerativeModel('gemini-1.5-pro-002')
        generations = []
        for prompt in prompts:
            response = model.generate_content(
                    prompt,
                    generation_config=self.generation_config,
                    safety_settings = self.safety_settings,
                    stream=False,
            )
            text = response.text if hasattr(response,'text') else str(response)
            generations.append([Generation(text = text)])
        return LLMResult(generations=generations)
    @property
    def _llm_type(self) -> str:
        return "custom_vertexai"
    

class CustomVertexAIEmbeddings(Embeddings):
    model_name: str = "text-embedding-004"
    def __init__(self, **kwargs: Any):
        super().__init__(**kwargs)
        vertexai.init(
            project="anbc-dev-growth-anlyt",
            location="us-central1",
            api_endpoint="us-central1-aiplatform.googleapis.com"
        )
        self.model = TextEmbeddingModel.from_pretrained(self.model_name)
    def embed_documents(self, texts: List[str]) -> List[List[float]]:
        try:
            embeddings = self.model.get_embeddings(texts) # type: ignore
            return [embedding.values for embedding in embeddings]
        except Exception as e:
            return [[] for _ in texts]
    def embed_query(self,text: str) -> List[float]:
        try:
            embeddings = self.model.get_embeddings([text])
            return embeddings[0].values
        except Exception as e:
            return []
    @property
    def _embedding_type(self) -> str:
        return "custom_vertexai_embeddings"
    
class BusinessAssistantBackend:
    def __init__(self):
        vertexai.init(
            project="anbc-dev-growth-anlyt",
            location="us-central1",
            api_endpoint="us-central1-aiplatform.googleapis.com"
        )
        self.credentials, self.project = google.auth.default()
        aiplatform.init(project=self.project,credentials=self.credentials) # type: ignore

        self.llm = CustomVertexAILLM()
        self.embeddings = CustomVertexAIEmbeddings()
        # self.chat_history = ChathistoryManager()
        self.load_documents()



    def load_documents(self):
        with open("/app/./src/controllers/BRDTest.txt",'r') as f:
            text = f.read()
        chunks = chunk_text(text, chunk_size =60, overlap =15)   
        docs = [Document(page_content=chunk) for chunk in chunks]
        self.vector_store = FAISS.from_documents(docs,embedding = self.embeddings)

    def llm_call(self,query):
        return self.llm.generate([query]).generations[0][0].text


    def bd_answer(self,query):
        docs = self.vector_store.similarity_search(query,k = 2)
        bd_context = "\n".join(d.page_content for d in docs)
        query = ""
   
        PROMPT = f"""
        You are an expert in extracting information from Business Documents. You will be provided some context from business document.
        Your task is to provide an answer of a user's question based on given context.
 
        User Question: {query}
        Business Context: {bd_context}
 
        Please Follow Below Guidelines while answering:
        1. If the answer is not found in the context, respond with:
            Answer: [NOT_FOUND]
        2. If the answer is found in the context, respond with:
            Answer: <your answer here>
        """
 
        response = self.llm.generate([PROMPT]).generations[0][0].text
        # response = call_custom_endpoint(PROMPT)
        # response = call_custom_endpoint(PROMPT)
        # print("------------------------")
        # print(response)
        # print("------------")
        return response
 
 # - Calls leads and sales can only be used with sum function in a Big Query
    

    def generate_response(self,query:str) -> tuple[str,str]:
        # self.chat_history.add_message("user",query)
        bd_response = self.bd_answer(query)
        data_dict_str = pd.read_excel("/app/./src/controllers/MMPDNew.xlsx").to_markdown()
 
        # history_context = get_formated_history(historyList)
        prompt = f""" 
        {promptMain.mmpdMain}
        """
        # print(history_context)
        
   
         
        full_response = self.llm.generate([prompt]).generations[0][0].text
        decision = full_response.split("<decision>")[1].split("</decision>")[0].strip()
        response = full_response.split("<response>")[1].split("</response>")[0].strip()
        explanation = full_response.split("<brief-explanation>")[1].split("</brief-explanation>")[0].strip()
        assumptions = full_response.split("<assumptions>")[1].split("</assumptions>")[0].strip()
        columns = full_response.split("<columns>")[1].split("</columns>")[0].strip()
        decision = """PROJECT: 'anbc-hcb-prod'
                        DATASET: 'msa_share_mcr_hcb_prod'
                        TABLE:   'MMPD_CONSUMPTION_CURR_PREV_AEP' """
        # self.chat_history.add_message("assistant",response)
        #print(history_context)
        if "NOT_FOUND" not in bd_response:
            explanation = "BD_Response: "+bd_response+"\n"+explanation
        return decision, response, explanation, assumptions, columns # type: ignore
        # self.chat_history.add_message("user",query)


    def generate_response_mc(self,query:str) -> tuple[str,str]:
        # self.chat_history.add_message("user",query)
        # bd_response = self.bd_answer(query)
        # data_dict_str = pd.read_excel("/app/./src/controllers/MMPDNew 1.xlsx").to_markdown()
        data_dict1 = pd.read_excel(r'/app/./src/controllers/hotspot.xlsx').to_markdown()
        data_dict2 = pd.read_excel(r'/app/./src/controllers/DOL_AEP.xlsx').to_markdown()
 
        # history_context = get_formated_history(historyList)
        prompt = f"""  {promptMain.mcMain} """
        # print(history_context)
        
   
         
        full_response = self.llm.generate([prompt]).generations[0][0].text
        decision = full_response.split("<decision>")[1].split("</decision>")[0].strip()
        response = full_response.split("<response>")[1].split("</response>")[0].strip()
        explanation = full_response.split("<brief-explanation>")[1].split("</brief-explanation>")[0].strip()
        assumptions = full_response.split("<assumptions>")[1].split("</assumptions>")[0].strip()
        columns = full_response.split("<columns>")[1].split("</columns>")[0].strip()
        # decision = """PROJECT: 'anbc-hcb-prod'
        #                 DATASET: 'msa_share_mcr_hcb_prod'
        #                 TABLE:   'MMPD_CONSUMPTION_CURR_PREV_AEP' """
        # self.chat_history.add_message("assistant",response)
        # #print(history_context)
        # if "NOT_FOUND" not in bd_response:
        #     explanation = "BD_Response: "+bd_response+"\n"+explanation
        return decision, response, explanation, assumptions, columns # type: ignore
       
prompt_clari_MMPD = f"""
    {promptMain.mmpdClarification}
    """

prompt_clari_MC = f"""
    {promptMain.mcClarification}
    """

 
def format_conversation_history(history:list)-> str:
    conversation = ""
    for turn in history:
        if turn['role'] == 'user':
            conversation+=f"\nUser: {turn['content']}"
        elif turn['role'] == "Agent":
            conversation+=f"\nAssistant: {turn['content']}"
    # conversation+="\nAssistant: "
    print(conversation.strip())
    return conversation.strip()

# 1. If user request does not say anything about timing then always consider default timing= {default_period}
#         2. If user request mention latest AEP then use timing: {current_AEP}
#         3. If user request mentions last or previous AEP then use timing: {last_AEP}
#         4. If user request mentions last lockin or previous lockin then use timing: {last_lockin}
# 9. Dont ask silly questions, if user is asking about calls then do need to ask which calls directly use calls column likewise for leads and market ask well.

def remove_query_ready_flag(text):
    try:
        pattern = r'\[?\s*query_ready\s*:\s*(True|False)\s*\]?'
        cleaned_text = re.sub(pattern,'',text)
        return re.sub(r'\s{2,}',' ',cleaned_text).strip()
    except Exception as e:
        return text
 

def build_prompt_with_history(history:list,data_dict:str) -> str:
    prompt =""
    if table == "Medicare Marketing Performance":
        prompt = prompt_clari_MMPD.format(default_timing,latest_aep,pre_aep,data_dict,format_conversation_history(history))
        print(prompt)
        return prompt.strip()
    if table == "Mission Control":
        data_dict1 = pd.read_excel(r'/app/./src/controllers/hotspot.xlsx').to_markdown()
        data_dict2 = pd.read_excel(r'/app/./src/controllers/DOL_AEP.xlsx').to_markdown()
        prompt = prompt_clari_MC.format(format_conversation_history(history),data_dict1,data_dict2)
        print(prompt)
        return prompt.strip()
    else: 
        print("I am in else one")
        return "Dummy test"


#---------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------

def getBackend():
    return BusinessAssistantBackend()



def chat_history_str(chat_list):
    res = ""
    for turn in chat_list:
        role = turn.get("role","unknown")
        content = turn.get("content","")
        res+=f"{role}: {content}\n"
    return res.strip()

def response_format(full_response):
    try:

        response = full_response.split("<response>")[1].split("</response>")[0].strip()
        explanation = full_response.split("<brief-explanation>")[1].split("</brief-explanation>")[0].strip()
        assumptions = full_response.split("<assumptions>")[1].split("</assumptions>")[0].strip()
        
        return response,explanation,assumptions
    except:
        return full_response,"None","None"


def conversBiDevDb():
    try:
        
        data = request.get_json()
        print(data)
 
        backend = getBackend()
               
        prompt = data['value']
        history = data['history']
        global table
        table = data['table'] 

        global promptMain

        json_str = data['prompt'].decode('utf-8')
        print(json_str)
        promptMain = json.loads(json_str)
        print(promptMain)


       

        print(table)
        global historyList
        historyList = history
        global data_dict_str
        data_dict_str = pd.read_excel("/app/./src/controllers/MMPDNew.xlsx").to_markdown()
        
        historyList.append({"role":"user","content":prompt})
        # historyList.insert(0, {"role":"user","content":prompt})
        print(historyList)

        prompt1 = build_prompt_with_history(historyList,data_dict_str)

        result = backend.llm_call(prompt1)
        

        if ("True"  in result) and table == "Medicare Marketing Performance":
            result = remove_query_ready_flag(result)
            decision, response, explanation, assumptions, columns = backend.generate_response(result) # type: ignore
            
            final = json.dumps(response)
            newExplanation = json.dumps(explanation)
            newDecision = json.dumps(decision)
            newColumns = json.dumps(columns)
            
            return jsonify({"message": "AI result Fetched Successfully","data":final, "explanation":newExplanation, "decision":newDecision, "assumptions":assumptions, "columns":newColumns}), 200  

        elif ("True"  in result) and table == "Mission Control":
            result = remove_query_ready_flag(result)
            decision, response, explanation, assumptions, columns = backend.generate_response_mc(result) # type: ignore
           
            final = json.dumps(response)
            newExplanation = json.dumps(explanation)
            newDecision = json.dumps(decision)
            newColumns = json.dumps(columns)
            
            return jsonify({"message": "AI result Fetched Successfully","data":final, "explanation":newExplanation, "decision":newDecision, "assumptions":assumptions, "columns":newColumns}), 200  
     
        else:
            result = remove_query_ready_flag(result)
            final = json.dumps(result)
            newAssumptions = json.dumps("None")
            newExplanation = json.dumps("None")
            newDecision = json.dumps("None")
            newColumns = json.dumps("[]")

    
            return jsonify({"message": "AI result Fetched Successfully","data":final, "explanation":newExplanation, "decision":newDecision, "assumptions":newAssumptions, "columns":newColumns}), 200  
    

    

       
    except Exception as e:
        print(e)
        return jsonify({'error': 'Internal server error'}), 500
   
   
@module_blueprints.route('/conversational-bi-dev-db', methods=['POST']) # type: ignore
def converse_bi_dev_db():
    result = conversBiDevDb()
    return result
