/*Film Fellini prodotti dopo il 1960*/
SELECT Titolo FROM Film f WHERE f.[Anno Produzione] > 1960 AND f.Regista = 'Fellini'

/*Il titolo e la durata dei film di fantascienza giapponesi o francesi prodotti dopo il 1990*/
SELECT f.Titolo, f.Durata FROM Film f WHERE f.Genere = 'Fantascienza' AND (f.Nazionalita = 'Jpn' OR f.Nazionalita = 'Fra') AND f.[Anno Produzione] > 1990

/*Il titolo dei film di fantascienza giapponesi prodotti dopo il 1990 oppure francesi*/
SELECT f.Titolo FROM Film f WHERE f.Genere = 'Fantascienza' AND ((f.Nazionalita = 'Jpn' AND f.[Anno Produzione] > 1990) OR f.Nazionalita = 'Fra')

/*I titolo dei film dello stesso regista di “Casablanca”*/
SELECT f.Titolo FROM Film f WHERE f.Regista = (SELECT f1.Regista FROM Film f1 WHERE f1.Titolo = 'Casablanca')

/*Il titolo ed il genere dei film proiettati il giorno di Natale 2004*/
/*DISTINCT serve per togliere le ripetizioni*/
SELECT DISTINCT f.Titolo, f.Genere FROM Film f, Proiezioni p WHERE f.CodFilm = p.CodFilm AND p.DataProiezione = '20041225'

/*Il titolo ed il genere dei film proiettati a Napoli il giorno di Natale 2004*/
SELECT DISTINCT f.Titolo, f.Genere FROM Film f, Sale s, Proiezioni p WHERE f.CodFilm = p.CodFilm AND p.CodSala = s.CodSala AND s.Citta = 'Napoli' AND p.DataProiezione = '20041225'

/*I nomi delle sale di Napoli in cui il giorno di Natale 2004 è stato proiettato un film con R.Williams*/
SELECT DISTINCT s.Nome FROM Sale s, Proiezioni p, Attori a, Recita r WHERE p.CodSala = s.CodSala AND a.CodAttore = r.CodAttore AND r.CodFilm = p.CodFilm AND s.Citta = 'Napoli' AND p.DataProiezione = '20041225' AND a.Nome = 'R. Williams'

/*Il titolo dei film in cui recita M. Mastroianni e S.Loren*/
/*In questa query chiediamo con la prima select i film in cui recita Loren e la seconda select chiede Mastroianni*/
SELECT f.Titolo FROM Film f, Recita r, Attori a WHERE a.CodAttore = r.CodAttore AND f.CodFilm = r.CodFilm AND f.CodFilm IN (SELECT f.CodFilm FROM Film f, Recita r, Attori a WHERE a.CodAttore = r.CodAttore AND f.CodFilm = r.CodFilm AND a.Nome = 'Mastroianni') AND a.Nome = 'Loren'
/*Oppure si potrebbero mettere due volte le tabelle, sdoppiare le tabelle*/
SELECT f.Titolo FROM Film f, Recita r, Attori a, Recita r2, Attori a2 WHERE a.CodAttore = r.CodAttore AND f.CodFilm = r.CodFilm AND a.Nome = 'Mastroianni' AND a2.CodAttore = r2.CodAttore AND f.CodFilm = r2.CodFilm AND a2.Nome = 'Loren'
/*Oppure ancora si potrebbero fare due select dopo la where di una select*/

/*Per ogni film che è stato proiettato a Pisa nel gennaio 2005, il titolo del film e il nome della sala.*/
SELECT f.Titolo, s.Nome FROM Film f, Sale s, Proiezioni p WHERE f.CodFilm = p.CodFilm AND p.CodSala = s.CodSala AND s.Citta = 'Pisa' AND p.DataProiezione BETWEEN '20050101' AND '20050131'