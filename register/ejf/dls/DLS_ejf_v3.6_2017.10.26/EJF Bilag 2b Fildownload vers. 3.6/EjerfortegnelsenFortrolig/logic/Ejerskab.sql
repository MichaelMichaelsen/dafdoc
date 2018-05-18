SELECT * FROM Ejerskab ejerskab
INNER JOIN EBR.EJENDOMSBELIGGENHED eb ON ejerskab.BESTEMTFASTEJENDOMBFENR = eb.BESTEMTFASTEJENDOMBFENR

--Sørg for at en gyldig kombination af inputs er givet
WHERE (@Kommunekode IS NOT NULL)

--Filtrer på inputs
AND (eb.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)


-- Bitemporalitet
[snippet_bitemp_full_with_period(ejerskab)]
[snippet_bitemp_full_now(eb)]

AND (@Status IS NULL OR ejerskab.status = @Status)
;