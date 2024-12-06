package com.techelevator.model;

public class QuestionRequestModel {
    private String question;
    private String session_id;

    // Getters and Setters
    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getSession_id() {
        return session_id;
    }

    public void setSessionId(String session_id) {
        this.session_id = session_id;
    }
}
