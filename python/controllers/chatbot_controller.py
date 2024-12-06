from fastapi import FastAPI
from services.GeminiService import GeminiService

app = FastAPI()


@app.post("/ask")
async def ask_question(question: str):
    response = GeminiService.generate_response(question)
    return {"answer": response.text}