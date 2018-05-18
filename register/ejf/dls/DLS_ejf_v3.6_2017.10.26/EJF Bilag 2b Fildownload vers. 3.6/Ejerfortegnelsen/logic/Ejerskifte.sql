SELECT * FROM Ejerskifte ejerskifte
LEFT JOIN (SELECT DISTINCT id_lokalId, ejerskifteLokalId, status FROM Ejerskabsskifte) ejerskabsskifte ON ejerskabsskifte.ejerskifteLokalId = ejerskifte.id_lokalId AND ejerskabsskifte.status = ejerskifte.status
LEFT JOIN Ejerskifte_BilagsbankRef bilagsreferencer ON bilagsreferencer.ejerskifteObjectid = ejerskifte.objectid
INNER JOIN EBR.EJENDOMSBELIGGENHED eb ON ejerskifte.BESTEMTFASTEJENDOMBFENR = eb.BESTEMTFASTEJENDOMBFENR

--Sørg for at en gyldig kombination af inputs er givet
WHERE (@Kommunekode IS NOT NULL)

--Filtrer på inputs
AND (eb.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)

-- Bitemporalitet
[snippet_bitemp_full(ejerskifte)]
[snippet_bitemp_full_now(eb)]

AND (@Status IS NULL OR ejerskifte.status = @Status)
;