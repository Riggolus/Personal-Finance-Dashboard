package com.techelevator.dao;



import com.techelevator.model.DBJoke;

import java.util.List;

public interface JokeDao {

    void saveJoke(String joke, int userId);

    List<DBJoke> getAllJokes(int userId);
}
