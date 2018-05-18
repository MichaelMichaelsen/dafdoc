SELECT * FROM Handelsoplysninger handelsoplysning
INNER JOIN Ejerskifte ejerskifte ON handelsoplysning.id_lokalId = ejerskifte.handelsoplysningerLokalId
INNER JOIN EBR.EJENDOMSBELIGGENHED eb ON ejerskifte.BESTEMTFASTEJENDOMBFENR = eb.BESTEMTFASTEJENDOMBFENR

--Sørg for at en gyldig kombination af inputs er givet
WHERE (@Kommunekode IS NOT NULL)

--Filtrer på inputs
AND (eb.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)

-- Bitemporalitet
[snippet_bitemp_full(handelsoplysning)]
[snippet_bitemp_full(ejerskifte)]
[snippet_bitemp_full_now(eb)]

AND (@Status IS NULL OR (handelsoplysning.status = @Status AND ejerskifte.status = @Status))
;