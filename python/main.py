from fastapi import FastAPI
from pydantic import BaseModel
import google.generativeai as genai

app = FastAPI()

# Initialize Gemini model (make sure the API key is correctly set)
genai.configure(api_key="AIzaSyDQyZMN3NLzp7SaEQHIvN_8Rxpa1ZrM8Co")
model = genai.GenerativeModel("gemini-1.5-flash")

# In-memory storage for conversations
conversations = {}

# Define the request body to include both question and session_id
class ChatRequest(BaseModel):
    session_id: str
    question: str

@app.post("/ask")
async def ask_question(request: ChatRequest):
    session_id = request.session_id
    question = request.question

    # Check if the session ID exists
    if session_id not in conversations:
        conversations[session_id] = []  # Start a new conversation history

    # Append the new question to the conversation history
    conversations[session_id].append({"question": question})

    # Generate context from the conversation history (only recent parts if needed)
    context = ""
    for entry in conversations[session_id]:
        if "question" in entry:
            context += f"Q: {entry['question']}"
        if "answer" in entry:
            context += f" A: {entry['answer']}\n"

    # Get the response from Gemini
    response = model.generate_content(f"{context}\nQ: {question}")

    # Append the response to the conversation history
    conversations[session_id].append({"answer": response.text})

    # Return the answer
    return {"answer": response.text}
