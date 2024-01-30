const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Create a MySQL connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'db_stg2',
});

connection.connect();

app.use(bodyParser.json());

// Define a route that calls the stored procedure
app.get('/get_top_tracks/:count', (req, res) => {
  const topCount = parseInt(req.params.count) || 15; // Parse count as an integer, default to 10 if not provided
  connection.query('CALL GetTopTracks(?)', [topCount], (error, results, fields) => {
    if (error) throw error;
    res.json(results[0]); // Assuming the result is in the first element of the results array
  });
});

app.get('/get_yearly_song_count', (req, res) => {
  connection.query('SELECT YEAR(track_album_release_date) AS year, COUNT(*) AS count FROM album GROUP BY YEAR(track_album_release_date)', (error, results, fields) => {
    if (error) throw error;
    res.json(results);
  });
});

app.get('/get_loudness_enerygy', (req, res) => {
  connection.query('SELECT loudness , energy from track', (error, results, fields) => {
    if (error) throw error;
    res.json(results);
  });
});

app.get('/get_albums', (req, res) => {
  connection.query('SELECT * FROM album limit 15', (error, results, fields) => {
    if (error) throw error;
    res.json(results);
  });
});

app.get('/get_danceability_energy', (req, res) => {
  connection.query('SELECT danceability, energy FROM track', (error, results, fields) => {
    if (error) throw error;
    res.json(results);
  });
});


app.post('/update_data', (req, res) => {
  const { id, newData } = req.body;
  connection.query('UPDATE your_table SET column_name = ? WHERE id = ?', [newData, id], (error, results, fields) => {
    if (error) throw error;
    res.json({ success: true });
  });
});

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
