package com.techelevator.model;

public class DBJoke {

    private int jokeId;
    private int userId;
    private String joke;

    public int getJokeId() {
        return jokeId;
    }

    public void setJokeId(int jokeId) {
        this.jokeId = jokeId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getJoke() {
        return joke;
    }

    public void setJoke(String joke) {
        this.joke = joke;
    }

    @Override
    public String toString() {
        return "DBJoke{" +
                "jokeId=" + jokeId +
                ", userId=" + userId +
                ", joke='" + joke + '\'' +
                '}';
    }
}
