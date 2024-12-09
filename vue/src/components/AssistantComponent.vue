<template>
    <div id="assistant">
        <h3>Testing Assistant</h3>
        <form action="">
            <label for="assistantInput">Enter a command:</label>
            <input type="text" id="assistantInput" name="assistantInput">
            <button @click.prevent="getResponse">Submit</button>
        </form>
        <div id="assistantOutput">
            <p>Assistant output will go here</p>
        </div>
    </div>
</template>

<script>
import GoogleGeminiService from '../services/GoogleGeminiService';

export default {
    data() {
        return {
            assistantInput: "",
            assistantOutput: ""
        }
    },
    methods: {
        getResponse() {
            GoogleGeminiService.postGeminiMessage(this.assistantInput)
                .then(response => {
                    this.assistantOutput = response.data;
                })
                .catch(e => {
                    console.log(e);
                });
        }
    }
}
</script>

<style>
</style>