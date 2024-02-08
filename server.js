/* *******************************************************************************************
* Autor: B. Niederlaender, J. Mossner, 1/2024
* *******************************************************************************************
* Beschreibung:
* Express-Server, um CRUD-Operationen vom Browser entgegen zunehmen an der DB durchzuführen
* *******************************************************************************************
* Hinweise
* npm install node
* npm init -y
* npm install mysql
* npm install body-parser
* npm install express
** ***************************************************************************************** */
// Referenz: www.npmjs.com/package/mysql

const mysql = require("mysql");
const express = require('express');
var app = express();
const path = require('path');
const bodyParser = require('body-parser');

const port = 3000;

app.use(bodyParser.json());

const config = {
    host: 'localhost',
    database: 'efz_zeugnis',
    user: "efz_zeugnis",
    password: 'efz_zeugnisPW'
}

const connection = mysql.createConnection(config)

connection.connect(function(err) {
    if (err) throw err;
    console.log('Connected to MySQL database:', connection.config.database);
    /*
     var sqlstmt = 'SELECT * from user';
     // Das SQL-Statement wird vorbereitetet
     connection.query(sqlstmt, function (err, result) {
         if (err) throw err;
         // console.log('Data from MySQL:');
         //console.log(result); //
     });
     */
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});



//Zeigt alle
app.get('/Lernende', (req, res) => {
    connection.query('SELECT Lernende.id, Lernende.name, Klasse.name AS klassenname FROM Lernende INNER JOIN Klasse ON Lernende.klasse_id = Klasse.id ORDER BY Lernende.id ASC;', (err, rows, fields) => {
        if (!err) {
            console.log(rows);
            res.send(rows);
        } else {
            console.log(err);
            res.status(500).send('Fehler bei der Abfrage der Lernenden');
        }
    });
});

//Zeigt nur einer mit user/:id
app.get('/Lernende/:id', (req, res) => {
    connection.query('SELECT Lernende.id, Lernende.name, Klasse.name as klassenname FROM Lernende INNER JOIN Klasse ON Lernende.klasse_id = Klasse.id WHERE Lernende.id = ?', [req.params.id], (err, rows, fields) => {
        if (!err) {
            console.log(rows);
            if (rows.length > 0) {
                res.json(rows[0]); // Gibt nur den ersten Datensatz zurück, da die ID eindeutig ist
            } else {
                res.status(404).send('Lernender nicht gefunden');
            }
        } else {
            console.log(err);
            res.status(500).send(err);
        }
    });
});


//löscht einen user mit user/:id
app.delete('/Lernende/:id', (req, res) => {
    connection.query('DELETE FROM Lernende WHERE id = ?', [req.params.id], (err, result) => {
        if (!err) {
            res.send(`Lernender mit der ID ${req.params.id} wurde gelöscht`);
        } else {
            console.log(err);
            res.status(500).send(err);
        }
    });
});
