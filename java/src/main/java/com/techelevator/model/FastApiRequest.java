package com.techelevator.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class FastApiRequest {
    private String question;

    @JsonProperty("session_id")
    private String session_id;

    public FastApiRequest(String question, String session_id) {
        this.question = question;
        this.session_id = session_id;
    }

    // Getters and Setters
    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getSessionId() {
        return session_id;
    }

    public void setSessionId(String session_id) {
        this.session_id = session_id;
    }
}
