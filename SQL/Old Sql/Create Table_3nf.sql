USE DB_STG2;
CREATE TABLE IF NOT EXISTS playlist_genre (
    playlist_id VARCHAR(255) primary KEY,
    playlist_genre VARCHAR(100),
    playlist_subgenre VARCHAR(100),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id)
);
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
    DB_STG2.playlist;
ALTER TABLE playlist
DROP column playlist_genre;
ALTER TABLE playlist
DROP column playlist_subgenre;