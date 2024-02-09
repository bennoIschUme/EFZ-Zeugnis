CREATE DATABASE efz_zeugnis;

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


-- Read: Zeugnisse eines bestimmten Lernenden lesen
SELECT * FROM Zeugnis WHERE lernende_id = 1;

-- Read: Daten aus der Relationstabelle KlasseModul mit Bedingung lesen
SELECT * FROM KlasseModul WHERE klasse_id = 1;


-- Update: Daten in einer Tabelle aktualisieren
UPDATE Lernende SET name = 'Herbert Lanthen' WHERE id = 1;

-- Read: Daten aus einer Tabelle lesen
SELECT * FROM Lernende;

-- Delete: Daten aus einer Tabelle löschen
DELETE FROM Noteneintrag WHERE zeugnis_id = 1 AND modul_id = 3;

-- Create: Eine neue Note mit dem Wert 5.0 einfügen
INSERT INTO Noteneintrag (zeugnis_id, modul_id, note) VALUES (17, 3, 2.0);




/* usecase */
-- Delete: Ein Zeugnis löschen, das älter als 10 Jahre ist
DELETE FROM Zeugnis WHERE datum < DATE_SUB(CURDATE(), INTERVAL 10 YEAR);
