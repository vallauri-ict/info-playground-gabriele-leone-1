CREATE TABLE Aereoporto
(
	citta VARCHAR(50) NOT NULL PRIMARY KEY,
	nazione VARCHAR(3) NOT NULL,
	numPiste INT NOT NULL
)

CREATE TABLE Volo
(
	idVolo INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
	giornoSettimana SMALLINT NOT NULL,
	cittaPartenza VARCHAR(50) NOT NULL,
	oraPartenza TIME NOT NULL,
	cittaArrivo VARCHAR(50) NOT NULL,
	oraArrivo TIME NOT NULL,
	tipoAereo VARCHAR(30) NOT NULL
)

CREATE TABLE Aereo
(
	tipoAereo VARCHAR(30) NOT NULL PRIMARY KEY,
	numPasseggeri INT NOT NULL,
	qtaMerci INT NOT NULL
)