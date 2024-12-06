import google.generativeai as genai

# Initialize Gemini API with your API key
genai.configure(api_key="AIzaSyDQyZMN3NLzp7SaEQHIvN_8Rxpa1ZrM8Co")
model = genai.GenerativeModel("gemini-1.5-flash")

# Function to interact with the Gemini model
def generate_answer(question: str) -> str:
    response = model.generate_content(question)
    return response.text