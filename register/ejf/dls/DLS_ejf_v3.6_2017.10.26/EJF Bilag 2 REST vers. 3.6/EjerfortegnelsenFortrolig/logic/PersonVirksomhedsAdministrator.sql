SELECT * FROM PersonEllerVirksomhedsadmini admin
-- Conditions for input parametre
WHERE NOT (@CPRnr IS NULL AND @CVRnr IS NULL AND @PVOId IS NULL)
AND (@CPRnr IS NULL OR admin.administreretPersonPersonNr = @CPRnr)
AND (@CVRnr IS NULL OR admin.administreretVirksomCVRNr = @CVRnr)
AND (@PVOId IS NULL OR admin.personVirksomOplLokalId = @PVOId)
AND (@Status IS NULL OR admin.status = @Status)
-- Bitemporalitet
[snippet_bitemp_full_with_period(admin)]
;