INSERT INTO DB_STG2.album (
    track_album_id,
    track_album_name,
    track_album_release_date
)
SELECT DISTINCT
    track_album_id,
    track_album_name,
    track_album_release_date
FROM
    DB_STG1.spotify_songs;

INSERT INTO DB_STG2.track (
    track_id,
    track_name,
    track_artist, 
    track_popularity,
    track_album_id,
    danceability,
    energy,
    key_value, 
    loudness,
    mode_value, 
    speechiness,
    acousticness,
    instrumentalness,
    liveness,
    valence,
    tempo,
    duration_ms
)
SELECT   
    track_id, 
    track_name, 
    track_artist, 
    track_popularity,
    track_album_id, 
    danceability, 
    energy, 
    _key, 
    loudness, 
    _mode, 
    speechiness,
    acousticness, 
    instrumentalness, 
    liveness, 
    valence, 
    tempo,
    duration_ms
FROM 
    DB_STG1.spotify_songs;


INSERT INTO DB_STG2.playlist (
    playlist_id,
    playlist_name,
    playlist_genre,
    playlist_subgenre
)
SELECT 
    DISTINCT playlist_id,
    playlist_name,
    playlist_genre,
    playlist_subgenre
FROM 
    DB_STG1.spotify_songs;

INSERT INTO DB_STG2.playlist_genre (
    playlist_id,
    playlist_genre,
    playlist_subgenre
)
SELECT
    playlist_id,
    playlist_genre,
    playlist_subgenre
FROM
    DB_STG1.spotify_songs;
    
INSERT INTO DB_STG2.tracks_in_playlist (
    playlist_id,
    track_id
)
SELECT
    playlist_id,
    track_id
FROM
    DB_STG1.spotify_songs;



