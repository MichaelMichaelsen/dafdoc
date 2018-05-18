SELECT * FROM PersonEllerVirksomhedsadmini admin
-- Joins for administrerende person-/virksomhedsoplysning
LEFT JOIN PersonVirksomhedsoplys pv ON pv.id_lokalId = admin.personVirksomhedOplysLokalId
LEFT JOIN AlternativAdresse pv_alt_adresse ON pv_alt_adresse.id_lokalId = pv.alternativAdresseLokalId
LEFT JOIN DAR.Adresse pv_dar_adresse ON pv_dar_adresse.id_lokalId = pv.adresseLokalId
-- Joins for administrerende virksomhed
LEFT JOIN CVR.Virksomhed virksomhed ON virksomhed.CVRNummer = admin.virksomhedCVRNr
LEFT JOIN CVR.Reklamebeskyttelse virksomhed_reklame_beskyttelse ON virksomhed_reklame_beskyttelse.CVREnhedsId = virksomhed.id
LEFT JOIN CVR.Navn virksomhed_navn ON virksomhed_navn.CVREnhedsId = virksomhed.id
LEFT JOIN CVR.Adressering virksomhed_cvr_adresse ON virksomhed_cvr_adresse.CVREnhedsId = virksomhed.id
    AND virksomhed_cvr_adresse.AdresseringAnvendelse = 'beliggenhedsadresse'
-- Joins for administrerende produktionsenhed
LEFT JOIN CVR.Produktionsenhed penhed ON penhed.pNummer = admin.produktionsenhedPNr
LEFT JOIN CVR.Reklamebeskyttelse penhed_reklame_beskyttelse ON penhed_reklame_beskyttelse.CVREnhedsId = penhed.id
LEFT JOIN CVR.Navn penhed_navn ON penhed_navn.CVREnhedsId = penhed.id
LEFT JOIN CVR.Adressering penhed_cvr_adresse ON penhed_cvr_adresse.CVREnhedsId = penhed.id
    AND penhed_cvr_adresse.AdresseringAnvendelse = 'beliggenhedsadresse'
-- Joins for administrerende person
LEFT JOIN CPR.Personnummer person_personnumre ON person_personnumre.personnummer = admin.personPersonNr
LEFT JOIN CPR.Person person ON person.id = person_personnumre.personid
LEFT JOIN CPR.Beskyttelse person_beskyttelse ON person_beskyttelse.personid = person.id
LEFT JOIN CPR.Navn person_navn ON person_navn.personid = person.id 
    AND NOT EXISTS ([snippet_cpr_beskyttet(admin, personPersonNr)])
LEFT JOIN CPR.CprAdresse person_cpr_adresse ON person_cpr_adresse.personid = person.id
    AND NOT EXISTS ([snippet_cpr_beskyttet(admin, personPersonNr)])
LEFT JOIN CPR.UdrejseIndrejse person_ud_ind_rejse ON person_ud_ind_rejse.personid = person.id
    AND NOT EXISTS ([snippet_cpr_beskyttet(admin, personPersonNr)])
LEFT JOIN DAR.Adresse person_dar_adresse ON person_dar_adresse.id_lokalId = person_cpr_adresse.daradresse
    AND NOT EXISTS ([snippet_cpr_beskyttet(admin, personPersonNr)])
-- Conditions for input parametre
WHERE NOT (@CPRnr IS NULL AND @CVRnr IS NULL AND @PVOId IS NULL)
AND (@CPRnr IS NULL OR admin.administreretPersonPersonNr = @CPRnr)
AND (@CVRnr IS NULL OR admin.administreretVirksomCVRNr = @CVRnr)
AND (@PVOId IS NULL OR admin.personVirksomOplLokalId = @PVOId)
AND (@Status IS NULL OR (
         admin.status = @Status
    AND (pv.status IS NULL OR pv.status = @Status)
    AND (pv_alt_adresse.status IS NULL OR pv_alt_adresse.status = @Status)))
-- Bitemporalitet for administrator
[snippet_bitemp_virkning(admin)]
-- Bitemporalitet for administrerende person-/virkomsomhedsoplysning
[snippet_bitemp_virkning_optional(pv, objectid)]
[snippet_bitemp_virkning_optional(pv_alt_adresse, objectid)]
[snippet_bitemp_virkning_optional(pv_dar_adresse, id_lokalId)]
-- Bitemporalitet for administrerende virksomhed
[snippet_bitemp_virkning_optional(virksomhed, id)]
[snippet_bitemp_virkning_optional(virksomhed_reklame_beskyttelse, CVREnhedsId)]
[snippet_bitemp_virkning_optional(virksomhed_navn, CVREnhedsId)]
[snippet_bitemp_virkning_optional(virksomhed_cvr_adresse, CVREnhedsId)]
-- Bitemporalitet for administrerende produktionsenhed
[snippet_bitemp_virkning_optional(penhed, id)]
[snippet_bitemp_virkning_optional(penhed_reklame_beskyttelse, CVREnhedsId)]
[snippet_bitemp_virkning_optional(penhed_navn, CVREnhedsId)]
[snippet_bitemp_virkning_optional(penhed_cvr_adresse, CVREnhedsId)]
-- Bitemporalitet for administrerende person
[snippet_bitemp_virk_optional(person_personnumre, personid)]
[snippet_bitemp_virkning_cpr_optional(person, id)]
[snippet_bitemp_virk_optional(person_beskyttelse, personid)]
[snippet_bitemp_virk_optional(person_navn, personid)]
[snippet_bitemp_virk_optional(person_cpr_adresse, personid)]
[snippet_bitemp_virk_optional(person_ud_ind_rejse, personid)]
[snippet_bitemp_virkning_optional(person_dar_adresse, id_lokalId)]
;