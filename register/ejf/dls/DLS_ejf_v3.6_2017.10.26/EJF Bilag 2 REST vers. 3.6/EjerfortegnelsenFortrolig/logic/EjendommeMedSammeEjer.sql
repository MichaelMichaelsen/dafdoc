SELECT * FROM Ejerskab ejerskab
-- Conditions for input parametre
WHERE NOT (@CPRnr IS NULL AND @CVRnr IS NULL AND @PVOId IS NULL)
AND (@CPRnr IS NULL OR ejerskab.ejendePersonPersonNR = @CPRnr)
AND (@CVRnr IS NULL OR ejerskab.ejendeVirksomhedCVRNr = @CVRnr)
AND (@PVOId IS NULL OR ejerskab.ejeroplysningerLokalId = @PVOId)
AND (@Status IS NULL OR ejerskab.status = @Status)
-- Bitemporalitet
[snippet_bitemp_full_with_period(ejerskab)]
;