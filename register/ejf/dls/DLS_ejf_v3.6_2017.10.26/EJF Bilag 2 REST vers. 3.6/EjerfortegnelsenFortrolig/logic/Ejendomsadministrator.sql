SELECT * FROM Ejendomsadministrator admin
-- Conditions for input parametre
WHERE admin.bestemtFastEjendomBFENr = @BFEnr
AND (@Status IS NULL OR admin.status = @Status)
-- Bitemporalitet
[snippet_bitemp_full_with_period(admin)]
;