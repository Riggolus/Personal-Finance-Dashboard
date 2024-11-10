package com.techelevator.model;

public class DBArtist {

    private int artistId;
    private String spotifyId;
    private int followers;
    private String name;

    public int getArtistId() {
        return artistId;
    }

    public void setArtistId(int artistId) {
        this.artistId = artistId;
    }

    public String getSpotifyId() {
        return spotifyId;
    }

    public void setSpotifyId(String spotifyId) {
        this.spotifyId = spotifyId;
    }

    public int getFollowers() {
        return followers;
    }

    public void setFollowers(int followers) {
        this.followers = followers;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "DBArtist{" +
                "artistId=" + artistId +
                ", spotifyId='" + spotifyId + '\'' +
                ", followers=" + followers +
                ", name='" + name + '\'' +
                '}';
    }
}
