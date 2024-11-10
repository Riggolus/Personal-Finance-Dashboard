package com.techelevator.dao;


import com.techelevator.model.DBJoke;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.util.List;

public class JdbcJokeDao implements JokeDao {

    private JdbcTemplate jdbcTemplate;

    public JdbcJokeDao(DataSource dataSource){
        jdbcTemplate = new JdbcTemplate(dataSource);
    }


    @Override
    public void saveJoke(String joke, int userId) {
        String sql = "INSERT INTO joke (user_id, joke) VALUES (?, ?)";
        jdbcTemplate.update(sql, userId, joke);
    }

    @Override
    public List<DBJoke> getAllJokes(int userId) {
        return List.of();
    }
}
