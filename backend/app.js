const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

// Create a MySQL connection
const connection = mysql.createConnection({
  host: '192.168.100.4',
  user: 'root',
  password: 'orthorhombic777',
  database: 'lab',
});

connection.connect();

app.use(bodyParser.json());

// Define routes for handling database operations
app.get('/get_data', (req, res) => {
  connection.query('SELECT * FROM niko', (error, results, fields) => {
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