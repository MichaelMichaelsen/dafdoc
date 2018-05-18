SELECT * FROM PersonVirksomhedsoplys pv 
LEFT JOIN AlternativAdresse alt_adresse ON alt_adresse.id_lokalId = pv.alternativAdresseLokalId
-- Conditions for input parametre
WHERE NOT (@PVOId IS NULL AND @FiktivtPVnummer IS NULL)
AND (@PVOId IS NULL OR pv.id_lokalId = @PVOId)
AND (@FiktivtPVnummer IS NULL OR pv.fiktivtPVnummer = @FiktivtPVnummer)
AND (@Status IS NULL OR (
        pv.status = @Status
    AND (alt_adresse.status IS NULL OR alt_adresse.status = @Status)))
-- Bitemporalitet
[snippet_bitemp_full(pv)]
[snippet_bitemp_full_optional(alt_adresse, objectid)]
;