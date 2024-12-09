<template>
    <div id="assistant" v-if="showAssistant">
        <h3>Assistant powered by Gemini</h3>
        <form @submit.prevent="getResponse">
            <label for="assistantInput">How can I help you?</label>
            <input type="text" id="assistantInput" v-model="assistantInput" name="assistantInput">
            <button id="get-response" type="submit">Submit</button>
        </form>
        <div id="assistantOutput">
            <div id="conversationBox" ref="conversationBox">
                <div
                    v-for="(message, index) in conversation"
                    :key="index"
                    :class="['message', message.role]"
                >
                    <div class="message-content">
                        <strong>{{ message.role === 'user' ? 'You' : 'Assistant' }}:</strong>
                        {{ message.text }}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <button id="assistant-button" @click="startAssistant">Message</button>
</template>


<script>
import GoogleGeminiService from '../services/GoogleGeminiService';
import TransactionsService from '../services/TransactionsService';

export default {
    data() {
        return {
            showAssistant: false,
            assistantInput: "",
            assistantOutput: "",
            conversation: [],
            transactions: []
        };
    },
    methods: {
        getTransactionsForAssistant() {
            TransactionsService.getTransactions()
                .then(response => {
                    this.transactions = response.data;
                })
                .catch(e => console.error(e));
        }, 
        getResponse() {
            // Push user input to the conversation
            this.conversation.push({ role: 'user', text: this.assistantInput });

            // Send input to Gemini API
            GoogleGeminiService.postGeminiMessage(this.assistantInput)
                .then(response => {
                    // Add assistant's response to the conversation
                    this.conversation.push({ role: 'assistant', text: response.data.answer.replace(/^A: /, '') });
                    this.assistantInput = "";
                    this.scrollToBottom();
                })
                .catch(e => console.error(e));
        },
        scrollToBottom() {
            this.$nextTick(() => {
                const conversationBox = this.$refs.conversationBox;
                conversationBox.scrollTop = conversationBox.scrollHeight;
            });
        },
        startAssistant() {
            // Ensure the transactions are serialized to JSON format
            const transactionsData = JSON.stringify(this.transactions, null, 2); 

            // Send transactions and start the assistant
            GoogleGeminiService.postGeminiMessage(
                `The following is the current user's transactional data: ${transactionsData}`
            )
            .then(() => {
                this.showAssistant = !this.showAssistant;
            })
            .catch(e => console.error(e));
            }
    },
    mounted() {
        this.getTransactionsForAssistant();
    }
};
</script>


<style>
#assistant {
    display: flex;
    flex-direction: column;
    background-color: white;
    padding: 1rem;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    position: fixed;
    bottom: 80px;
    right: 20px;
    z-index: 1000;
    max-width: 400px; /* Increased max-width */
    width: 100%;
    height: 70%; /* Better height usage */
    overflow: hidden; /* Prevent content overflow */
}

#assistant h3 {
    margin: 0 0 1rem;
    font-size: 1.2rem;
    text-align: center;
}

#assistant form {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

#assistantInput {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
}

#get-response {
    padding: 0.75rem;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1rem;
}

#get-response:hover {
    background-color: #0056b3;
}

#assistantOutput {
    flex-grow: 1; /* Takes remaining space */
    margin-top: 1rem;
    border-top: 1px solid #ccc;
    padding-top: 1rem;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

#conversationBox {
    flex-grow: 1; /* Makes the conversation box stretch */
    overflow-y: auto;
    padding: 1rem;
    border: 1px solid #ccc;
    border-radius: 10px;
    background-color: #f9f9f9;
    display: flex;
    flex-direction: column;
}

.message {
    display: flex;
    justify-content: flex-start;
    margin: 0.5rem 0;
    padding: 0.5rem;
    border-radius: 8px;
}

.message.user {
    justify-content: flex-start;
    background-color: #e1f5fe;
    align-self: flex-start;
}

.message.assistant {
    justify-content: flex-end;
    background-color: #e8f5e9;
    align-self: flex-end;
}

.message-content {
    max-width: 80%;
    word-wrap: break-word;
}

#assistant-button {
    position: fixed;
    bottom: 20px;
    right: 20px;
    padding: 1rem;
    border-radius: 50%;
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>
