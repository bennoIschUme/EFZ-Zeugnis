-- ---------------------------------------------------------------------------------------------------------------------
-- 1. Für die neue DB-Instanz müssen wir einige DB-Umgebungsparameter setzten
-- ---------------------------------------------------------------------------------------------------------------------
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;


-- ---------------------------------------------------------------------------------------------------------------------
-- 2. Anlegen der Datenbank
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
-- 2.1 Alle verfügbaren Datenbank-Instanzen anzeigen lassen
-- ---------------------------------------------------------------------------------------------------------------------
SHOW DATABASES;

-- ---------------------------------------------------------------------------------------------------------------------
-- 2.2 Gegebenenfalls müssen wir DB-Instanzen löschen
-- ---------------------------------------------------------------------------------------------------------------------
DROP DATABASE appDB;



-- ---------------------------------------------------------------------------------------------------------------------
-- 2.3 Anlegen einer druckfrischen Datenbank-Instanz
-- ---------------------------------------------------------------------------------------------------------------------
CREATE DATABASE appDB /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;


SELECT user FROM mysql.user;

-- ---------------------------------------------------------------------------------------------------------------------
-- 3.2 Gegebenenfalls müssen wir DB-User löschen
-- ---------------------------------------------------------------------------------------------------------------------
DROP USER 'appAdmin'@'localhost';


-- ---------------------------------------------------------------------------------------------------------------------
-- 3.3 Aus Sicherheitsgründen können wir den root-user für unseren Zugriff auf die DB nicht gebrauchen.
--     Daher legen wir einen neuen User an mit eingeschränkten Berechtigungen.
-- ---------------------------------------------------------------------------------------------------------------------
CREATE USER  'appAdmin'@'localhost' IDENTIFIED BY'appAdminPW';
ALTER USER 'appAdmin'@'localhost' IDENTIFIED WITH mysql_native_password BY 'appAdminPW';
--    host: 'localhost',
--    user: 'appAdmin',
--    password: 'appAdminPW',
--    database: 'appDB',

-- ---------------------------------------------------------------------------------------------------------------------
-- 3.4 Privilegien/Berechtigungen setzten für die neuen User auf der neuen DB
-- ---------------------------------------------------------------------------------------------------------------------
GRANT all privileges ON appDB.* TO 'appAdmin'@'localhost';


-- ---------------------------------------------------------------------------------------------------------------------
-- 3.5 Berechtigungen müssen jetzt noch aktiviert werden
-- ---------------------------------------------------------------------------------------------------------------------
FLUSH PRIVILEGES;

-- ---------------------------------------------------------------------------------------------------------------------
-- 3.6 Berechtigungen anzeigen lassen
-- ---------------------------------------------------------------------------------------------------------------------
SELECT user,host FROM mysql.user;
SHOW GRANTS FOR appAdmin@localhost;



-- ---------------------------------------------------------------------------------------------------------------------
-- 4. Anlegen und füllen der Tabelle
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
-- 4.1 Die neue DB wird in die Console genommen, damit Berechtigungen müssen jetzt noch aktiviert werden
-- ---------------------------------------------------------------------------------------------------------------------
USE appDB;

-- ---------------------------------------------------------------------------------------------------------------------
-- 4.2 Sicherheitshalber löschen der Tabelle customer
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS user;


-- ---------------------------------------------------------------------------------------------------------------------
-- 4.3 Anlegen der Tabelle user
-- ---------------------------------------------------------------------------------------------------------------------
CREATE TABLE user (
                      ID INT AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(50),
                      vorname VARCHAR(50),
                      username VARCHAR(50)
);

-- ---------------------------------------------------------------------------------------------------------------------
-- 4.4 Füllen der Tabelle mit Initialdaten
-- ---------------------------------------------------------------------------------------------------------------------
INSERT INTO user (name, vorname, username) VALUES
                                               ('Doe', 'John', 'johndoe'),
                                               ('Smith', 'Alice', 'alicesmith'),
                                               ('Johnson', 'Michael', 'michaelj'),
                                               ('Williams', 'Emma', 'emmawill'),
                                               ('Brown', 'James', 'jamesbrown'),
                                               ('Davis', 'Olivia', 'oliviad'),
                                               ('Garcia', 'Daniel', 'danigarcia'),
                                               ('Wilson', 'Sophia', 'sophiawil'),
                                               ('Martinez', 'William', 'willmart'),
                                               ('Anderson', 'Ava', 'avaanderson');


-- ---------------------------------------------------------------------------------------------------------------------
-- 4.5 Einige Kontrollselects
-- ---------------------------------------------------------------------------------------------------------------------
Select * from user;
select current_date;


-----------------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

CREATE DATABASE efz_zeugnis;
show databases ;

use efz_zeugnis;

CREATE TABLE Modul (
                       id INT PRIMARY KEY,
                       name VARCHAR(50) NOT NULL);

/* schon ausgeführt */

CREATE TABLE Lernende (
                          id INT PRIMARY KEY,
                          name VARCHAR(50) NOT NULL,
                          klasse_id INT NOT NULL,
                          FOREIGN KEY (klasse_id) REFERENCES Klasse(id)
);

/* schon ausgeführt */

CREATE TABLE Semester (
                          id INT PRIMARY KEY,
                          name VARCHAR(50) NOT NULL);

/* schon ausgeführt */

CREATE TABLE Zeugnis (
                         id INT PRIMARY KEY,
                         lernende_id INT NOT NULL,
                         semester_id INT NOT NULL,
                         datum DATE NOT NULL,
                         FOREIGN KEY (lernende_id) REFERENCES Lernende(id),
                         FOREIGN KEY (semester_id) REFERENCES Semester(id)
);

/* schon ausgeführt */

CREATE TABLE Noteneintrag (
                              id INT PRIMARY KEY,
                              zeugnis_id INT NOT NULL,
                              modul_id INT NOT NULL,
                              note DECIMAL(2,1) NOT NULL CHECK (note >= 1.0 AND note <= 6.0),
                              FOREIGN KEY (zeugnis_id) REFERENCES Zeugnis(id),
                              FOREIGN KEY (modul_id) REFERENCES Modul(id)
);

/* schon ausgeführt */

CREATE TABLE Klasse (
                        id INT PRIMARY KEY,
                        name VARCHAR(50) NOT NULL);

/* schon ausgeführt */

CREATE TABLE ModulSemester (
                               id INT PRIMARY KEY,
                               modul_id INT NOT NULL,
                               semester_id INT NOT NULL,
                               FOREIGN KEY (modul_id) REFERENCES Modul(id),
                               FOREIGN KEY (semester_id) REFERENCES Semester(id)
);

/* schon ausgeführt */

CREATE TABLE KlasseModul (
                             id INT PRIMARY KEY,
                             klasse_id INT NOT NULL,
                             modul_id INT NOT NULL,
                             FOREIGN KEY (klasse_id) REFERENCES Klasse(id),
                             FOREIGN KEY (modul_id) REFERENCES Modul(id)
);

/* schon ausgeführt */

-- Füllen Sie die Tabellen mit einigen Beispieldaten
INSERT INTO Lernende (id, name, klasse_id) VALUES
                                               (1, 'Lernender 1', 1),
                                               (2, 'Lernender 2', 1);

/* schon ausgeführt */

INSERT INTO Modul (id, name) VALUES
                                 (1, 'Modul 1'),
                                 (2, 'Modul 2'),
                                 (3, 'Modul 3'),
                                 (4, 'Modul 4'),
                                 (5, 'Modul 5'),
                                 (6, 'Modul 6'),
                                 (7, 'Modul 7'),
                                 (8, 'Modul 8');

/* schon ausgeführt */

INSERT INTO Semester (id, name) VALUES
                                    (1, 'Semester 1'),
                                    (2, 'Semester 2'),
                                    (3, 'Semester 3'),
                                    (4, 'Semester 4');

/* schon ausgeführt */

INSERT INTO Zeugnis (id, lernende_id, semester_id, datum) VALUES
                                                              (1, 1, 1, '2023-01-31'),
                                                              (2, 1, 2, '2023-06-30'),
                                                              (3, 2, 1, '2023-01-31'),
                                                              (4, 2, 2, '2023-06-30');

/* schon ausgeführt */

INSERT INTO Noteneintrag (id, zeugnis_id, modul_id, note) VALUES
                                                              (1, 1, 1, 5.5),
                                                              (2, 1, 2, 4.5),
                                                              (3, 1, 3, 5.0),
                                                              (4, 1, 4, 5.0),

                                                              (5, 2, 5, 4.0),
                                                              (6, 2, 6, 5.5),
                                                              (7, 2, 7, 4.0),
                                                              (8, 2, 8, 3.5),

                                                              (9, 3, 1, 5.0),
                                                              (10, 3, 2, 6.0),
                                                              (11, 3, 3, 3.0),
                                                              (12, 3, 4, 4.0),

                                                              (13, 4, 5, 5.0),
                                                              (14, 4, 6, 3.5),
                                                              (15, 4, 7, 1.5),
                                                              (16, 4, 8, 4.0);


/* schon ausgeführt */

INSERT INTO Klasse (id, name) VALUES
    (1, 'Klasse 1');

/* schon ausgeführt */

INSERT INTO ModulSemester (id, modul_id, semester_id) VALUES
                                                          (1, 1, 1),
                                                          (2, 2, 1),
                                                          (3, 3, 1),
                                                          (4, 4, 1),
                                                          (5, 5, 2),
                                                          (6, 6, 2),
                                                          (7, 7, 2),
                                                          (8, 8, 2);

/* schon ausgeführt */

INSERT INTO KlasseModul (id, klasse_id, modul_id) VALUES
                                                      (1, 1, 1),
                                                      (2, 1, 2),
                                                      (3, 1, 3),
                                                      (4, 1, 4),
                                                      (5, 1, 5),
                                                      (6, 1, 6),
                                                      (7, 1, 7),
                                                      (8, 1, 8);

/* schon ausgeführt */


SELECT user FROM mysql.user;


CREATE USER  'efz_zeugnis'@'localhost' IDENTIFIED BY'efz_zeugnisPW';
ALTER USER 'efz_zeugnis'@'localhost' IDENTIFIED WITH mysql_native_password BY 'efz_zeugnisPW';
GRANT all privileges ON efz_zeugnis.* TO 'efz_zeugnis'@'localhost';
FLUSH PRIVILEGES;

SELECT user,host FROM mysql.user;
SHOW GRANTS FOR efz_zeugnis@localhost;


select * from klasse;


SELECT Lernende.id, Klasse.name, Lernende.name
FROM Lernende
         INNER JOIN Klasse ON Lernende.klasse_id = Klasse.id
ORDER BY Lernende.id ASC;

UPDATE Lernende SET name = 'Frank Rosin' WHERE id = 1;

UPDATE Lernende SET name = 'Rosalinda Durftzmin' WHERE id = 2;

UPDATE Klasse SET name = 'ME21c' WHERE id = 1;

SELECT * FROM Klasse;
