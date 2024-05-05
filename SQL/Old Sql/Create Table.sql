CREATE DATABASE IF NOT EXISTS DB_STG2;
/* Album table */
CREATE TABLE IF NOT EXISTS DB_STG2.album (
    track_album_id VARCHAR(255) PRIMARY KEY,
    track_album_name VARCHAR(255),
    track_album_release_date DATE
);
/* Track Table */
CREATE TABLE IF NOT EXISTS DB_STG2.track (
    track_id VARCHAR(255) PRIMARY KEY,
    track_name VARCHAR(255),
    track_artist VARCHAR(255),
    track_popularity INT,
    track_album_id VARCHAR(255),
    danceability FLOAT,
    energy FLOAT,
    key_value INT, 
    loudness FLOAT,
    mode_value INT, 
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_ms INT,
    FOREIGN KEY (track_album_id) REFERENCES album(track_album_id)
);
/* Playlist Table */
CREATE TABLE IF NOT EXISTS DB_STG2.playlist (
    playlist_id VARCHAR(255) PRIMARY KEY,
    playlist_name VARCHAR(255),
    playlist_genre VARCHAR(100),
    playlist_subgenre VARCHAR(100)
);

/* Tracks in Playlist */
CREATE TABLE IF NOT EXISTS DB_STG2.tracks_in_playlist (
    playlist_id VARCHAR(255),
    track_id VARCHAR(255),
    FOREIGN KEY (track_id) REFERENCES track(track_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    PRIMARY KEY (playlist_id, track_id)
);
