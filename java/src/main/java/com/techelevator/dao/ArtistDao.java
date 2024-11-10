package com.techelevator.dao;


import com.techelevator.model.DBArtist;
import se.michaelthelin.spotify.model_objects.specification.Artist;

import java.util.List;

public interface ArtistDao {

    void saveArtist(Artist artist, int userId);

    List<DBArtist> getAllArtistsByUserId(int userId);
}
