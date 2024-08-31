const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const cors = require('cors');

const app = express();
const port = 3000;

// Initialize SQLite database
let db = new sqlite3.Database('./aquatrace.db', (err) => {
  if (err) {
    console.error(err.message);
  }
  console.log('Connected to the aquatrace SQLite database.');
});

// Middleware
app.use(bodyParser.json());
app.use(cors());

// API endpoint to create a new user (for sign-up)
app.post('/api/signup', (req, res) => {
  const { name, surname, cellno, meterno, email, password, gender } = req.body;
  const hash = bcrypt.hashSync(password, 8);

  const sql = 'INSERT INTO users (name, surname, cellno, meterno, email, password, gender) VALUES (?, ?, ?, ?, ?, ?, ?)';
  db.run(sql, [name, surname, cellno, meterno, email, hash, gender], function (err) {
    if (err) {
      return res.status(400).json({ error: err.message });
    }
    res.json({ message: 'User created successfully!', id: this.lastID });
  });
});

// API endpoint to handle sign-in
app.post('/api/login', (req, res) => {
  const { meterno, email, password } = req.body;

  const sql = 'SELECT * FROM users WHERE meterno = ? AND email = ?';
  db.get(sql, [meterno, email], (err, user) => {
    if (err) {
      return res.status(400).json({ error: err.message });
    }
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    const validPassword = bcrypt.compareSync(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ error: 'Invalid password' });
    }

    res.json({ message: 'Login successful!', user });
  });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
