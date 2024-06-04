import functions_framework
import firebase_functions
from firebase_functions import https_fn
from typing import Any
import openai
import os
import json

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
def Question_Generator(request):
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
    
    MultipleChoicePrompt = """
    You are an assistant for reliable question-making tasks to teacher. Use the following pieces of retrieved context to answer the question. If you don't know the answer, just say that you don't know. Keep the answer concise.
    Your goal is to create a well crafted set of answers and question context for a test for a specific context. 
    Your answers will be used on a test to evaluate a students english skill.
    You will be given the context and your goal is to follow the output format below w/ guidelines 


    Question context create guidelines
    Question context should be ask a question for context detail.
    It can be question of subject, some words meaning, specific detail from context etc.
    The question context must be concise and clear. There is not allowed any confusing. And also must be perfect grammartically.

    Answer Choice Guidelines
    Answer choices must be written clearly and similarly to each other in content, length, and grammar; avoid giving clues through the use of faulty grammatical construction. 
    Make all distractors plausible; they should be common misconceptions that learners may have.
    There is 5 answer choices for each question.

    Rationale Guidelines
    All rationales should begin with "Correct." or "Incorrect."
    All answer options (including correct answer(s) and distractor(s)) must have their own rationale.
    Rationales should be unique for each answer option when appropriate. Rationales for distractors should ideally point out a learner's error in understanding and provide context to help them go back and figure out where they went wrong.
    Rationales should not refer to the answer by letter (ie, "option A is incorrect because...") because answer options will be randomized in our system. 
    Rationales for Distractors should not give away the correct answer to the question.
    Formative Quiz questions (which occur after each module), should include a sentence at the end of each rationale that points the learner back to the relevant video to review the information.
    Summative Quiz questions (which occur at the end of the course), should include a sentence at the end of each rationale that points the learner back to the relevant module to review the information. 

    Total Output structure Guidelines
    Q. Question context

    1. Answer 1
    2. Answer 2
    3. Answer 3
    4. Answer 4
    5. Answer 5

    A. Correct Answer : number of correct answer

    R. Rationale for correct answer


    Example of a Quiz Question Submission
    Below are examples for each component of a multiple-choice question item.

    Stem Example:
    A company is storing an access key (access key ID and secret access key) in a text file on a custom AMI. The company uses the access key to access DynamoDB tables from instances created from the AMI. The security team has mandated a more secure solution. Which solution will meet the security team's mandate?

    Answer Choices (Distractors 1~3 and Correct Answer 4) Example:
    1. Put the access key in an S3 bucket, and retrieve the access key on boot from the instance.
    2. Pass the access key to the instances through instance user data.
    3. Obtain the access key from a key server launched in a private subnet.
    4. Create an IAM role with permissions to access the table, and launch all instances with the new role. (correct)

    Rationale Example:
    [Formative] Data governance is not something specific to big data technologies.

    [Summative] It is not relevant to clarify the size of the big data team.

    {context}
    Question: {question}
    YOUR ANSWER:
    """

    SummaryTitlePrompt = """
    You are an assistant for reliable question-making tasks to teacher. Use the following pieces of retrieved context to answer the question. If you don't know the answer, just say that you don't know. Keep the answer concise.
    Your goal is to create a well crafted set of answers and question context for a test for a specific context. 
    Your answers will be used on a test to evaluate a students english skill.
    You will be given the context and your goal is to follow the output format below w/ guidelines 

    Question context create guidelines
    Question context should be ask a question for context detail.
    It can be question of expected summary and title from context.
    The question context must be concise and clear. There is not allowed any confusing. And also must be perfect grammartically.

    Answer Choice Guidelines
    Answer choices must be written clearly and similarly to each other in content, length, and grammar; avoid giving clues through the use of faulty grammatical construction. 
    Make all distractors plausible; they should be common misconceptions that learners may have.
    There is 5 answer choices for each question.

    Rationale Guidelines
    All rationales should begin with "Correct." or "Incorrect."
    All answer options (including correct answer(s) and distractor(s)) must have their own rationale.
    Rationales should be unique for each answer option when appropriate. Rationales for distractors should ideally point out a learner's error in understanding and provide context to help them go back and figure out where they went wrong.
    Rationales should not refer to the answer by letter (ie, "option A is incorrect because...") because answer options will be randomized in our system. 
    Rationales for Distractors should not give away the correct answer to the question.
    Formative Quiz questions (which occur after each module), should include a sentence at the end of each rationale that points the learner back to the relevant video to review the information.
    Summative Quiz questions (which occur at the end of the course), should include a sentence at the end of each rationale that points the learner back to the relevant module to review the information. 


    Total Output structure Guidelines
    Q. Question context

    1. Answer 1
    2. Answer 2
    3. Answer 3
    4. Answer 4
    5. Answer 5

    A. Correct Answer : number of correct answer

    R. Rationale for correct answer



    Example of a Quiz Question Submission
    Below are examples for each component of a multiple-choice question item.

    Stem Example:
    A company is storing an access key (access key ID and secret access key) in a text file on a custom AMI. The company uses the access key to access DynamoDB tables from instances created from the AMI. The security team has mandated a more secure solution. Which solution will meet the security team's mandate?

    Answer Choices (Distractors 1~3 and Correct Answer 4) Example:
    1. Put the access key in an S3 bucket, and retrieve the access key on boot from the instance.
    2. Pass the access key to the instances through instance user data.
    3. Obtain the access key from a key server launched in a private subnet.
    4. Create an IAM role with permissions to access the table, and launch all instances with the new role. (correct)

    Rationale Example:
    [Formative] Data governance is not something specific to big data technologies.

    [Summative] It is not relevant to clarify the size of the big data team.

    {context}
    Question: {question}
    YOUR ANSWER:
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
            text = body["passage"]
            questionTypes = body["questionTypes"]
        except (ValueError, KeyError):
            return ('Invalid request body', 400, headers)


        text = body["passage"]
        questionTypes = body["questionTypes"]


        llm = ChatOpenAI(model="gpt-3.5-turbo-0125")

        docs = Document(page_content=text)

        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_documents([docs])
        vectorstore = Chroma.from_documents(documents=splits, embedding=OpenAIEmbeddings())


        # Retrieve and generate using the relevant snippets of the blog.
        retriever = vectorstore.as_retriever(search_kwargs={"k": 2})

        ###
    

        questions = []

        for questionType in questionTypes:
            typeName = questionType['type']
            typeNum = questionType['count']

            ###
            print(typeName)
            print(typeNum)

            for i in range(typeNum):
                random_num = random.randint(1, 1000)

                Question = None
                if typeName == "MultipleChoice":
                    prompt = MultipleChoicePrompt
                    Question = "Question number " + str(random_num) + " : Make the Question."
                elif typeName == "Summary":
                    prompt = SummaryTitlePrompt
                    Question = "Question number " + str(random_num) + " : Make the Question to find the appropriate summary of context."
                elif typeName == "Title":
                    prompt = SummaryTitlePrompt
                    Question = "Question number " + str(random_num) + " : Make the Question to find the appropriate title of context."


                system_message_prompt = SystemMessagePromptTemplate.from_template(prompt)
                chat_prompt = ChatPromptTemplate.from_messages([system_message_prompt])
                rag_chain = (
                    {"context": retriever | format_docs, "question": RunnablePassthrough()}
                    | chat_prompt
                    | llm
                    | StrOutputParser()
                )

                llmResponse = rag_chain.invoke(Question)


                ###
                print(llmResponse)

                questionSentence = ""
                answerList = []
                answer = None
                reason = ""
                highlight = ""

                strings = llmResponse.split("\n")
                for st in strings:
                    s = st.lstrip()
                    if s[:2] == "Q.":
                        questionSentence = s[2:]
                    elif s[:2] == "A.":
                        answer = s[-1]  
                    elif s[:2] == "1." or s[:2] == "2." or s[:2] == "3." or s[:2] == "4." or s[:2] == "5.":
                        answerList.append(s[2:])
                    elif s[:2] == "R.":
                        reason = s[2:]


                #if questionSentence == "" or len(answerList) < 5 or answer == None or reason == "" or highlight == "":
                #    continue
                questions.append({"type": typeName,"text": questionSentence, "choices": answerList, "answer": answer, "comment": reason})
            
        return (json.dumps({'question': questions}, default=str, indent=2), 200, headers)
    else:
        return('Method not allowed', 405, headers)    








   

            

