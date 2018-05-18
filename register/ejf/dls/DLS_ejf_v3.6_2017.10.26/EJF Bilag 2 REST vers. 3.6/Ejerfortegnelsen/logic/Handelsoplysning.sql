SELECT * FROM Handelsoplysninger handelsoplysning
INNER JOIN Ejerskifte ejerskifte ON handelsoplysning.id_lokalId = ejerskifte.handelsoplysningerLokalId
-- Conditions for input parametre
WHERE NOT (@BFEnr IS NULL AND @HandelsOplysningsId IS NULL)
AND (@BFEnr IS NULL OR ejerskifte.bestemtFastEjendomBFENr = @BFEnr)
AND (@HandelsOplysningsId IS NULL OR ejerskifte.handelsoplysningerLokalId = @HandelsOplysningsId)
AND (@Status IS NULL OR (
        handelsoplysning.status = @Status
    AND ejerskifte.status = @Status))
-- Bitemporalitet
[snippet_bitemp_full(handelsoplysning)]
[snippet_bitemp_full(ejerskifte)]
;