/* 1- Targa e Marca delle Auto di cilindrata superiore a 2000 cc o di potenza superiore a 120 CV*/
SELECT a.Targa, a.Marca
FROM Autom a
WHERE (a.Cilindrata>2000 OR a.Potenza>120)

/*2- Nome del proprietario e Targa delle Auto di cilindrata superiore a 2000 cc oppure di potenza superiore a 120 CV*/
SELECT p.Nome, a.Targa
FROM Autom a, Proprietari p
WHERE a.CodF=p.CodF
AND (a.Cilindrata>2000 OR a.Potenza>120)

/* 3- Targa e Nome del proprietario delle Auto di cilindrata superiore a 2000 cc oppure di potenza superiore a 120 CV, assicurate presso la “AXEL”*/
SELECT * 
FROM Autom a, Proprietari p, Assicurazioni ass
WHERE a.CodF=p.CodF
AND a.CodAss=ass.CodAss
AND ass.Nome='AXEL'
AND (a.Cilindrata>2000 OR a.Potenza>120)

/* 4- Targa e Nome del proprietario delle Auto assicurate presso la “AXEL” e coinvolte in sinistri il 20/01/02*/
SELECT a.Targa, p.Nome
FROM Autom a, Proprietari p, Assicurazioni ass, Autocoinvolte ac, Sinistro s
WHERE a.CodF = p.CodF
AND a.CodAss = ass.CodAss
AND ass.Nome = 'AXEL'
AND ac.CodS = s.CodS
AND s.DataS = '2002-01-20'


/* 5- Per ciascuna Assicurazione, il nome, la sede ed il numero di auto assicurate*/
SELECT ass.Nome, ass.Sede, COUNT(*) AS NumAutoAss
FROM Assicurazioni ass, Autom a
WHERE ass.CodAss=a.CodAss
GROUP BY ass.Nome, ass.Sede, a.CodAss

/* 6- Per ciascuna auto “Fiat”, la targa dell’auto ed il numero di sinistri in cui è stata coinvolta*/
SELECT a.Targa, COUNT(*) AS NumSinistri
FROM Autom a, AutoCoinvolte ac
WHERE a.Marca='Fiat'
AND a.Targa=ac.Targa
GROUP BY a.Targa

/* 7- Per ciascuna auto coinvolta in più di un sinistro, la targa dell’auto, il nome dell’ Assicurazione ed il totale dei danni riportati*/
SELECT a.Targa, ass.Nome, SUM(ac.ImportoDelDanno) AS NumDanni
FROM Autom a, Assicurazioni ass, AutoCoinvolte ac
WHERE ac.Targa=a.Targa
AND ass.CodAss=a.CodAss
GROUP BY a.targa, ass.Nome
HAVING COUNT(*)>1

/* 8- CodF e Nome di coloro che possiedono più di un’auto*/
SELECT p.CodF, p.Nome
FROM Autom a, Proprietari p
WHERE a.CodF=p.CodF
GROUP BY p.CodF, p.Nome
HAVING COUNT(*)>1

/* 9- La targa delle auto che non sono state coinvolte in sinistri dopo il 20/01/01*/
SELECT a.Targa
FROM Autom a, AutoCoinvolte ac
WHERE a.Targa=ac.Targa
AND NOT EXISTS(SELECT * FROM Sinistro s WHERE s.DataS>'2001-01-20' AND s.CodS=ac.CodS)

/* 10- Il codice dei sinistri in cui non sono state coinvolte auto con cilindrata inferiore a 2000 cc*/
SELECT s.CodS
FROM AutoCoinvolte ac, Sinistro s
WHERE ac.CodS=s.CodS
AND NOT EXISTS(SELECT * FROM Autom a WHERE a.Cilindrata<2000 AND ac.Targa=a.Targa)