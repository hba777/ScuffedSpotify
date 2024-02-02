/*Correcting Column Names*/
ALTER TABLE DB_STG0.spotify_songs
RENAME COLUMN `key` to _key;
ALTER TABLE DB_STG0.spotify_songs
RENAME COLUMN `mode` to _mode;

-- Create the spotify_songs table in DB_STG1
CREATE TABLE IF NOT EXISTS DB_STG1.spotify_songs (
    track_id TEXT,
    track_name TEXT,
    track_artist TEXT,
    track_popularity INT DEFAULT NULL,
    track_album_id TEXT,
    track_album_name TEXT,
    track_album_release_date DATE DEFAULT NULL,
    playlist_name TEXT,
    playlist_id TEXT,
    playlist_genre TEXT,
    playlist_subgenre TEXT,
    danceability DOUBLE DEFAULT NULL,
    energy DOUBLE DEFAULT NULL,
    _key INT DEFAULT NULL,
    loudness DOUBLE DEFAULT NULL,
    _mode INT DEFAULT NULL,
    speechiness DOUBLE DEFAULT NULL,
    acousticness DOUBLE DEFAULT NULL,
    instrumentalness DOUBLE DEFAULT NULL,
    liveness DOUBLE DEFAULT NULL,
    valence DOUBLE DEFAULT NULL,
    tempo DOUBLE DEFAULT NULL,
    duration_ms INT DEFAULT NULL
);

-- Create the irregular_data table in DB_STG1
CREATE TABLE IF NOT EXISTS DB_STG1.irregular_data (
    track_id TEXT,
    track_name TEXT,
    track_artist TEXT,
    track_popularity INT DEFAULT NULL,
    track_album_id TEXT,
    track_album_name TEXT,
    track_album_release_date DATE DEFAULT NULL,
    playlist_name TEXT,
    playlist_id TEXT,
    playlist_genre TEXT,
    playlist_subgenre TEXT,
    danceability DOUBLE DEFAULT NULL,
    energy DOUBLE DEFAULT NULL,
    _key INT DEFAULT NULL,
    loudness DOUBLE DEFAULT NULL,
    _mode INT DEFAULT NULL,
    speechiness DOUBLE DEFAULT NULL,
    acousticness DOUBLE DEFAULT NULL,
    instrumentalness DOUBLE DEFAULT NULL,
    liveness DOUBLE DEFAULT NULL,
    valence DOUBLE DEFAULT NULL,
    tempo DOUBLE DEFAULT NULL,
    duration_ms INT DEFAULT NULL
);

USE DB_STG1;
DELIMITER //
CREATE TRIGGER before_insert_spotify_songs
BEFORE INSERT ON DB_STG1.spotify_songs
FOR EACH ROW
BEGIN
  DECLARE is_valid_format BOOLEAN;

  -- Define min and max values for tempo and loudness based on your dataset
  DECLARE min_loudness_value DOUBLE DEFAULT -60;
  DECLARE max_loudness_value DOUBLE DEFAULT 0;
  DECLARE min_tempo_value DOUBLE DEFAULT 0;
  DECLARE max_tempo_value DOUBLE DEFAULT 500; 

  -- Check the format for each attribute
  SET is_valid_format = (
    NEW.track_id IS NOT NULL AND NEW.track_id != '' AND CHAR_LENGTH(NEW.track_id) <= 255
    AND NEW.track_name IS NOT NULL AND NEW.track_name != '' AND CHAR_LENGTH(NEW.track_name) <= 255
    AND NEW.track_artist IS NOT NULL AND NEW.track_artist != '' AND CHAR_LENGTH(NEW.track_artist) <= 255
    AND NEW.track_popularity IS NOT NULL AND NEW.track_popularity BETWEEN 0 AND 100
    AND NEW.track_album_id IS NOT NULL AND NEW.track_album_id != '' AND CHAR_LENGTH(NEW.track_album_id) <= 255
    AND NEW.track_album_name IS NOT NULL AND NEW.track_album_name != '' AND CHAR_LENGTH(NEW.track_album_name) <= 255
    AND NEW.track_album_release_date IS NOT NULL AND STR_TO_DATE(NEW.track_album_release_date, '%Y-%m-%d') IS NOT NULL
    AND NEW.playlist_name IS NOT NULL AND NEW.playlist_name != '' AND CHAR_LENGTH(NEW.playlist_name) <= 255
    AND NEW.playlist_id IS NOT NULL AND NEW.playlist_id != '' AND CHAR_LENGTH(NEW.playlist_id) = 22
    AND NEW.playlist_genre IS NOT NULL AND NEW.playlist_genre != '' AND CHAR_LENGTH(NEW.playlist_genre) <= 100
    AND NEW.playlist_subgenre IS NOT NULL AND NEW.playlist_subgenre != '' AND CHAR_LENGTH(NEW.playlist_subgenre) <= 100
    AND NEW.danceability IS NOT NULL 
    AND NEW.energy IS NOT NULL AND NEW.energy BETWEEN 0 AND 1
    AND NEW._key IS NOT NULL AND NEW._key IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
    AND NEW.loudness IS NOT NULL AND NEW.loudness BETWEEN min_loudness_value AND max_loudness_value
    AND NEW._mode IS NOT NULL AND NEW._mode IN (1, 0)
    AND NEW.speechiness IS NOT NULL AND NEW.speechiness BETWEEN 0 AND 1
    AND NEW.acousticness IS NOT NULL AND NEW.acousticness BETWEEN 0 AND 1
    AND NEW.instrumentalness IS NOT NULL AND NEW.instrumentalness BETWEEN 0 AND 1
    AND NEW.liveness IS NOT NULL AND NEW.liveness BETWEEN 0 AND 1
    AND NEW.valence IS NOT NULL AND NEW.valence BETWEEN 0 AND 1
    AND NEW.tempo IS NOT NULL AND NEW.tempo BETWEEN min_tempo_value AND max_tempo_value
    AND NEW.duration_ms IS NOT NULL
  );

  -- If the format is not valid, insert the row into irregular_data table and cancel the original insert
  IF NOT is_valid_format THEN
    INSERT INTO DB_STG1.irregular_data VALUES (
      NEW.track_id,
      NEW.track_name,
      NEW.track_artist,
      NEW.track_popularity,
      NEW.track_album_id,
      NEW.track_album_name,
      NEW.track_album_release_date,
      NEW.playlist_name,
      NEW.playlist_id,
      NEW.playlist_genre,
      NEW.playlist_subgenre,
      NEW.danceability,
      NEW.energy,
      NEW._key,
      NEW.loudness,
      NEW._mode,
      NEW.speechiness,
      NEW.acousticness,
      NEW.instrumentalness,
      NEW.liveness,
      NEW.valence,
      NEW.tempo,
      NEW.duration_ms
    );

    -- Cancel the original insert
    SET NEW.track_id = NULL;
    SET NEW.track_name = NULL;
    SET NEW.track_artist = NULL;
    SET NEW.track_popularity = NULL;
    SET NEW.track_album_id = NULL;
    SET NEW.track_album_name = NULL;
    SET NEW.track_album_release_date = NULL;
    SET NEW.playlist_name = NULL;
    SET NEW.playlist_id = NULL;
    SET NEW.playlist_genre = NULL;
    SET NEW.playlist_subgenre = NULL;
    SET NEW.danceability = NULL;
    SET NEW.energy = NULL;
    SET NEW._key = NULL;
    SET NEW.loudness = NULL;
    SET NEW._mode = NULL;
    SET NEW.speechiness = NULL;
    SET NEW.acousticness = NULL;
    SET NEW.instrumentalness = NULL;
    SET NEW.liveness = NULL;
    SET NEW.valence = NULL;
    SET NEW.tempo = NULL;
    SET NEW.duration_ms = NULL;
  END IF;
END;
//
DELIMITER ;
