const mysql = require('mysql2/promise');


const connection = mysql.createPool({
    host : 'localhost',
    user : 'root',
    password : 'Masibonge@010505',
    database : 'wm_system_db'
});

module.exports = connection;
