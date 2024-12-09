<template>
    <div id="assistant">
        <h3>Assistant powered by Gemini</h3>
        <form @submit.prevent="getResponse">
            <label for="assistantInput">Enter a question:</label>
            <input type="text" id="assistantInput" v-model="assistantInput" name="assistantInput">
            <button type="submit">Submit</button>
        </form>
        <div id="assistantOutput">
            <div id="conversation" v-for="message in conversation" :key="message.text">
                <div><strong>{{ message.role }}:</strong> {{ message.text }}</div>
            </div>
        </div>
    </div>
</template>

<script>
import GoogleGeminiService from '../services/GoogleGeminiService';

export default {
    data() {
        return {
            assistantInput: "",
            assistantOutput: "",
            conversation: []
        };
    },
    methods: {
        getResponse() {
            console.log(this.assistantInput);

            this.conversation.push({ role: 'user', text: this.assistantInput });

            GoogleGeminiService.postGeminiMessage(this.assistantInput)
                .then(response => {
                    this.assistantOutput = response.data; 
                    console.log(response.data);

                    this.conversation.push({ role: 'assistant', text: this.assistantOutput.answer.replace(/^A: /, '') });
                })
                .catch(e => {
                    console.log(e); 
                });
        }
    }
}
</script>

<style>
#assistant {
    display: flex;
    flex-direction: column;
}

#assistant form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

#assistantInput {
    width: 100%;
}

#assistantOutput {
    margin-top: 1rem;
    border-top: 1px solid #ccc;
    padding-top: 1rem;
}

#conversation {
    margin-bottom: 1rem;
}
</style>
