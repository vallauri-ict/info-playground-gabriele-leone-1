/*Il nome dei musei di londra che non conservano opere di tiziano*/
SELECT m.NomeM
FROM Museo m
WHERE m.Citta='Londra'
AND NOT EXISTS(SELECT * 
				FROM Opera o
				WHERE o.NomeA='Tiziano'
				AND o.NomeM=m.NomeM
				)