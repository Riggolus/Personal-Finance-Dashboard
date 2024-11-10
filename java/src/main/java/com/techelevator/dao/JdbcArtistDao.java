package com.techelevator.dao;


import com.techelevator.model.DBArtist;
import org.springframework.jdbc.core.JdbcTemplate;
import se.michaelthelin.spotify.model_objects.specification.Artist;

import javax.sql.DataSource;
import java.util.List;

public class JdbcArtistDao implements ArtistDao{

    JdbcTemplate jdbcTemplate;

    public JdbcArtistDao(DataSource dataSource){
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public void saveArtist(Artist artist, int userId) {
        String sql = "INSERT INTO artist " +
                "(artist_name, followers, artist_spotify_id) VALUES (?, ?, ?) RETURNING artist_id ";
        int artistId = jdbcTemplate.queryForObject(sql, int.class, artist.getName(), artist.getFollowers().getTotal(),
                artist.getId());
        sql = "INSERT INTO users_artist (user_id, artist_id) VALUES (?, ?)";
        jdbcTemplate.update(sql, userId, artistId);

    }

    @Override
    public List<DBArtist> getAllArtistsByUserId(int userId) {
        return List.of();
    }
}
