SELECT ejerskabsskifte.* FROM Ejerskabsskifte ejerskabsskifte
INNER JOIN EJERSKIFTE ejerskifte ON ejerskabsskifte.EJERSKIFTELOKALID = ejerskifte.ID_LOKALID
INNER JOIN EBR.EJENDOMSBELIGGENHED eb ON ejerskifte.BESTEMTFASTEJENDOMBFENR = eb.BESTEMTFASTEJENDOMBFENR

--Sørg for at en gyldig kombination af inputs er givet
WHERE (@Kommunekode IS NOT NULL)

--Filtrer på inputs
AND (eb.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)

-- Bitemporalitet
[snippet_bitemp_full(ejerskabsskifte)]
[snippet_bitemp_full(ejerskifte)]
[snippet_bitemp_full_now(eb)]

AND (@Status IS NULL OR ejerskabsskifte.status = @Status)
;