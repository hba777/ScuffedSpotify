-- Attempting to insert a record that violates the validation conditions
INSERT INTO DB_STG1.spotify_songs (
    track_id, track_name, track_artist, track_popularity,
    track_album_id, track_album_name, track_album_release_date,
    playlist_name, playlist_id, playlist_genre, playlist_subgenre,
    danceability, energy, _key, loudness, _mode, speechiness,
    acousticness, instrumentalness, liveness, valence, tempo, duration_ms
) VALUES (
    'invalid_track_id', -- invalid track_id (length exceeds 255)
    '', -- empty track_name (invalid, should not be empty)
    'Artist XdZ', 
    110, -- invalid track_popularity (beyond the range 0-100)
    'album_123', 
    'Album ABC', 
    '2022-01-29', 
    'Cool Playlist', 
    'invalid_playlist_id', -- invalid playlist_id (length not equal to 22)
    'Pop', 
    'Subgenre XYZ', 
    1.2, -- invalid danceability (beyond the range 0-1)
    2.0, -- invalid energy (beyond the range 0-1)
    15, -- invalid _key (not in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    -70.0, -- invalid loudness (beyond the range -60 to 0)
    2, -- invalid _mode (not in [1, 0])
    1.5, -- invalid speechiness (beyond the range 0-1)
    1.2, -- invalid acousticness (beyond the range 0-1)
    1.5, -- invalid instrumentalness (beyond the range 0-1)
    1.2, -- invalid liveness (beyond the range 0-1)
    1.5, -- invalid valence (beyond the range 0-1)
    180.0, 
    300000 -- invalid duration_ms (beyond the range specified)
);