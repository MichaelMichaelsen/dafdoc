SELECT * FROM Ejendomsadministrator admin
INNER JOIN EBR.EJENDOMSBELIGGENHED eb ON admin.BESTEMTFASTEJENDOMBFENR = eb.BESTEMTFASTEJENDOMBFENR

--Sørg for at en gyldig kombination af inputs er givet
WHERE (@Kommunekode IS NOT NULL)

--Filtrer på inputs
AND (eb.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)

-- Bitemporalitet
[snippet_bitemp_full_with_period(admin)]
[snippet_bitemp_full_now(eb)]

AND (@Status IS NULL OR admin.status = @Status)
;