SELECT * FROM Ejerskifte ejerskifte
LEFT JOIN (SELECT DISTINCT id_lokalId, ejerskifteLokalId, status FROM Ejerskabsskifte) ejerskabsskifte ON ejerskabsskifte.ejerskifteLokalId = ejerskifte.id_lokalId AND ejerskabsskifte.status = ejerskifte.status
LEFT JOIN Ejerskifte_BilagsbankRef bilagsreferencer ON bilagsreferencer.ejerskifteObjectid = ejerskifte.objectid
-- Conditions for input parametre
WHERE NOT (@BFEnr IS NULL AND @EjerskifteId IS NULL)
AND (@BFEnr IS NULL OR ejerskifte.bestemtFastEjendomBFENr = @BFEnr)
AND (@EjerskifteId IS NULL OR ejerskifte.id_lokalId = @EjerskifteId)
AND (@Status IS NULL OR ejerskifte.status = @Status)
-- Bitemporalitet
[snippet_bitemp_full_period(ejerskifte)]
;