SELECT * FROM Ejerskab ejerskab
-- Conditions for input parametre
WHERE NOT (@BFEnr IS NULL AND @Ejerskabsid IS NULL)
AND (@BFEnr IS NULL OR ejerskab.bestemtFastEjendomBFENr = @BFEnr)
AND (@Ejerskabsid IS NULL OR ejerskab.id_lokalId = @Ejerskabsid)
AND (@Status IS NULL OR ejerskab.status = @Status)
-- Bitemporalitet
[snippet_bitemp_full_with_period(ejerskab)]
;