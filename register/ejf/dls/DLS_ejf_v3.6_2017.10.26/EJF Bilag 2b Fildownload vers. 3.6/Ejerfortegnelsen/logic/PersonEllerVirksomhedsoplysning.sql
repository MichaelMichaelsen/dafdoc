SELECT * FROM PersonVirksomhedsoplys pv 
LEFT JOIN AlternativAdresse alt_adresse ON alt_adresse.id_lokalId = pv.alternativAdresseLokalId

--Sørg for at en gyldig kombination af inputs er givet
WHERE (@Kommunekode IS NOT NULL)

--Filtrer på inputs
AND (pv.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)

-- Bitemporalitet
[snippet_bitemp_full(pv)]
[snippet_bitemp_full_optional(alt_adresse, objectid)]

AND (@Status IS NULL OR (
        pv.status = @Status
    AND (alt_adresse.status IS NULL OR alt_adresse.status = @Status)))
;