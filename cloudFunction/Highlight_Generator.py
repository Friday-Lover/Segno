import functions_framework
import firebase_functions
from firebase_functions import https_fn
# from firebase_admin import initialize_app
from typing import Any
#from openai import Configuration, OpenAIApi
import openai
import os
import json

#configuration = Configuration(api_key = firebase_functions.config().openai.key)
#openai = OpenAIApi(configuration)

#openai.api_key = firebase_functions.config().openai.key
#openai.api_key = os.getenv('OPENAI_KEY')

#openai_api_key = os.environ.get("OPENAI_API_KEY")

#configuration = Configuration(api_key=openai_api_key)
#openai = OpenAIApi(configuration)

#openai.api_key = os.environ.get("OPENAI_API_KEY")
openai.api_key = os.environ.get("openai")

from google.cloud import secretmanager

def access_secret_version(project_id: str, secret_id: str, version_id: str):
    return secretmanager.AccessSecretVersionResponse()
  

def format_docs(docs):
        return "\n\n".join(doc.page_content for doc in docs)

import random
from langchain import hub
from langchain_chroma import Chroma
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
from langchain_openai import OpenAIEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain.docstore.document import Document
from langchain_openai import ChatOpenAI
from langchain.prompts.chat import (
    ChatPromptTemplate,
    SystemMessagePromptTemplate,
    HumanMessagePromptTemplate,
)


@functions_framework.http
def Highlight_Generator(request):
###
###
    client = secretmanager.SecretManagerServiceClient()
    project_id = "segno-a4dbc"
    secret_id = "openai-key"
    version_id = "latest"
    name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"
    openai.api_key = client.access_secret_version(request={"name": name}).payload.data.decode("UTF-8")  
    os.environ["OPENAI_API_KEY"] = openai.api_key
###
###  
    
    HighlightPrompt = """
    You are an assistant for finding the original sentence on which the answer to the question is based. Use the following pieces of retrieved context to answer the question. If you don't know the answer, just say that you don't know. Keep the answer concise.
    Your goal is to find original sentence without any modifying that must be in the given the passage for the question and answer. 
    You will be given the context, question, answer, choice set and your goal is to follow the output format below w/ guidelines 

    Guidelines
    If the question type is summary or title, find the original main sentence of the passage without modifying.
    The original sentence must be perfectly same to given text.
    The original sentence must have the rationale that why the sentence is choosen.
    There is maximum 3 original sentence.


    {context}
    Question: {question}
    YOUR ANSWER:
    """

    BasePrompt = """
    You are an assistant for question-answering tasks. Use the following pieces of retrieved context to answer the question. If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise.

    Question: {question} 
    Context: {context} 
    Answer:
    """

    if request.method == 'OPTIONS':
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'        }
        return ('', 204, headers)
    headers = {
        'Access-Control-Allow-Origin': '*'
    }

    if request.method == 'POST':
        
        try:
            body = request.get_json(silent=True)
            if body is None:
                raise ValueError("Invalid JSON data")
                
            print("Received JSON data:", body)  # 받은 JSON 데이터 출력
                
            text = body["passage"]
            questions = body["questions"]
        except (ValueError, KeyError):
            return ('Invalid request body', 400, headers)

        text = body["passage"]
        questions = body["questions"]

        llm = ChatOpenAI(model="gpt-3.5-turbo-0125")
        docs = Document(page_content=text)
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_documents([docs])
        vectorstore = Chroma.from_documents(documents=splits, embedding=OpenAIEmbeddings())

        # Retrieve and generate using the relevant snippets of the blog.
        retriever = vectorstore.as_retriever(search_kwargs={"k": 2})

        prompt = HighlightPrompt

        system_message_prompt = SystemMessagePromptTemplate.from_template(prompt)
        chat_prompt = ChatPromptTemplate.from_messages([system_message_prompt])
        rag_chain = (
            {"context": retriever | format_docs, "question": RunnablePassthrough()}
            | chat_prompt
            | llm
            | StrOutputParser()
        )

        prompt = BasePrompt

        system_message_prompt = SystemMessagePromptTemplate.from_template(prompt)
        chat_prompt = ChatPromptTemplate.from_messages([system_message_prompt])
        base_rag_chain = (
            {"context": retriever | format_docs, "question": RunnablePassthrough()}
            | chat_prompt
            | llm
            | StrOutputParser()
        )

        highlights = []

        for question in questions:
            question_text = question['question']
            question_answer = question['answer']
            question_answerList = question['choices']
            question_reason = question['comment']
            question_type = question['type']

            if question_type == "MultipleChoice":               
                QuestionString = json.dumps(question).split("R.")[0] + "Find the original sentence without modifying that was used for rationale of the question and answer."
                llmResponse = rag_chain.invoke(QuestionString)
            elif question_type == "Summary" or question_type == "Title":
                QuestionString = "Find the sementically main sentences up to 3 without modifying."
                llmResponse = rag_chain.invoke(QuestionString)
            print(llmResponse)

            highlights.append({"question_text" : question_text, "highlight" : llmResponse})

        return (json.dumps({'highlights': highlights}, default=str, indent=2), 200, headers)
    else:
        return('Method not allowed', 405, headers)   


