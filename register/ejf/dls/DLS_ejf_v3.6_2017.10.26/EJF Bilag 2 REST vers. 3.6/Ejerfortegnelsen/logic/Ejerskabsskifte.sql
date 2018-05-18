SELECT * FROM Ejerskabsskifte ejerskabsskifte
-- Conditions for input parametre
WHERE ejerskabsskifte.id_lokalId = @EjerskabsskifteId
AND (@Status IS NULL OR ejerskabsskifte.status = @Status)
-- Bitemporalitet
[snippet_bitemp_full_with_period(ejerskabsskifte)]
;