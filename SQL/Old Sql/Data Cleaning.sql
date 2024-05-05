/*Correcting Column Names*/
ALTER TABLE DB_STG1.spotify_songs
RENAME COLUMN `key` to _key;
ALTER TABLE DB_STG1.spotify_songs
RENAME COLUMN `mode` to _mode;

/*Data Cleaning*/
DELETE FROM DB_STG1.spotify_songs
WHERE track_album_release_date IS NOT NULL 
AND track_album_release_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';
ALTER TABLE DB_STG1.spotify_songs
MODIFY COLUMN `track_album_release_date` DATE;