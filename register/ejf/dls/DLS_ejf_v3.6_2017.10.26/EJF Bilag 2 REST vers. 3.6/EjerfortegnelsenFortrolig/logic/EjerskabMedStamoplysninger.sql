SELECT *
FROM Ejerskab ejerskab
-- Joins for ejende person-/virksomhedsoplysning
LEFT JOIN PersonVirksomhedsoplys ejende_pv ON ejende_pv.id_lokalId = ejerskab.ejeroplysningerLokalId
LEFT JOIN AlternativAdresse ejende_pv_alt_adresse ON ejende_pv_alt_adresse.id_lokalId = ejende_pv.alternativAdresseLokalId
LEFT JOIN DAR.Adresse ejende_pv_dar_adresse ON ejende_pv_dar_adresse.id_lokalId = ejende_pv.adresseLokalId
-- Joins for ejende virksomhed
LEFT JOIN CVR.Virksomhed ejende_virksomhed ON ejende_virksomhed.CVRNummer = ejerskab.ejendeVirksomhedCVRNr
LEFT JOIN CVR.Reklamebeskyttelse ejende_virksomhed_reklame_beskyttelse ON ejende_virksomhed_reklame_beskyttelse.CVREnhedsId = ejende_virksomhed.id
LEFT JOIN CVR.Navn ejende_virksomhed_navn ON ejende_virksomhed_navn.CVREnhedsId = ejende_virksomhed.id
LEFT JOIN CVR.Adressering ejende_virksomhed_cvr_adresse ON ejende_virksomhed_cvr_adresse.CVREnhedsId = ejende_virksomhed.id
    AND ejende_virksomhed_cvr_adresse.AdresseringAnvendelse = 'beliggenhedsadresse'
-- Joins for ejende person
LEFT JOIN CPR.Personnummer ejende_person_personnumre ON ejende_person_personnumre.personnummer = ejerskab.ejendePersonPersonNR
LEFT JOIN CPR.Person ejende_person ON ejende_person.id = ejende_person_personnumre.personid
LEFT JOIN CPR.Beskyttelse ejende_person_beskyttelse ON ejende_person_beskyttelse.personid = ejende_person.id
LEFT JOIN CPR.Navn ejende_person_navn ON ejende_person_navn.personid = ejende_person.id 
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, ejendePersonPersonNR)])
LEFT JOIN CPR.CprAdresse ejende_person_cpr_adresse ON ejende_person_cpr_adresse.personid = ejende_person.id
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, ejendePersonPersonNR)])
LEFT JOIN CPR.UdrejseIndrejse ejende_person_ud_ind_rejse ON ejende_person_ud_ind_rejse.personid = ejende_person.id
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, ejendePersonPersonNR)])
LEFT JOIN DAR.Adresse ejende_person_dar_adresse ON ejende_person_dar_adresse.id_lokalId = ejende_person_cpr_adresse.daradresse
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, ejendePersonPersonNR)])
-- Joins for administrerende person-/virksomhedsoplysning
LEFT JOIN PersonVirksomhedsoplys admin_pv ON admin_pv.id_lokalId = ejerskab.administratoroplysLokalId
LEFT JOIN AlternativAdresse admin_pv_alt_adresse ON admin_pv_alt_adresse.id_lokalId = admin_pv.alternativAdresseLokalId
LEFT JOIN DAR.Adresse admin_pv_dar_adresse ON admin_pv_dar_adresse.id_lokalId = admin_pv.adresseLokalId
-- Joins for administrerende virksomhed
LEFT JOIN CVR.Virksomhed admin_virksomhed ON admin_virksomhed.CVRNummer = ejerskab.administrerendeVirksomhedCVRNr
LEFT JOIN CVR.Reklamebeskyttelse admin_virksomhed_reklame_beskyttelse ON admin_virksomhed_reklame_beskyttelse.CVREnhedsId = admin_virksomhed.id
LEFT JOIN CVR.Navn admin_virksomhed_navn ON admin_virksomhed_navn.CVREnhedsId = admin_virksomhed.id
LEFT JOIN CVR.Adressering admin_virksomhed_cvr_adresse ON admin_virksomhed_cvr_adresse.CVREnhedsId = admin_virksomhed.id
    AND admin_virksomhed_cvr_adresse.AdresseringAnvendelse = 'beliggenhedsadresse'
-- Joins for administrerende produktionsenhed
LEFT JOIN CVR.Produktionsenhed admin_penhed ON admin_penhed.pNummer = ejerskab.produktionsenhedPNr
LEFT JOIN CVR.Reklamebeskyttelse admin_penhed_reklame_beskyttelse ON admin_penhed_reklame_beskyttelse.CVREnhedsId = admin_penhed.id
LEFT JOIN CVR.Navn admin_penhed_navn ON admin_penhed_navn.CVREnhedsId = admin_penhed.id
LEFT JOIN CVR.Adressering admin_penhed_cvr_adresse ON admin_penhed_cvr_adresse.CVREnhedsId = admin_penhed.id
    AND admin_penhed_cvr_adresse.AdresseringAnvendelse = 'beliggenhedsadresse'
-- Joins for administrerende person
LEFT JOIN CPR.Personnummer admin_person_personnumre ON admin_person_personnumre.personnummer = ejerskab.administrerendePersonPersonNr
LEFT JOIN CPR.Person admin_person ON admin_person.id = admin_person_personnumre.personid
LEFT JOIN CPR.Beskyttelse admin_person_beskyttelse ON admin_person_beskyttelse.personid = admin_person.id
LEFT JOIN CPR.Navn admin_person_navn ON admin_person_navn.personid = admin_person.id 
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, administrerendePersonPersonNr)])
LEFT JOIN CPR.CprAdresse admin_person_cpr_adresse ON admin_person_cpr_adresse.personid = admin_person.id
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, administrerendePersonPersonNr)])
LEFT JOIN CPR.UdrejseIndrejse admin_person_ud_ind_rejse ON admin_person_ud_ind_rejse.personid = admin_person.id
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, administrerendePersonPersonNr)])
LEFT JOIN DAR.Adresse admin_person_dar_adresse ON admin_person_dar_adresse.id_lokalId = admin_person_cpr_adresse.daradresse
    AND NOT EXISTS ([snippet_cpr_beskyttet(ejerskab, administrerendePersonPersonNr)])
-- Conditions for input parametre
WHERE (@BFEnr IS NULL OR ejerskab.bestemtFastEjendomBFENr = @BFEnr)
AND (@Ejerskabsid IS NULL OR ejerskab.id_lokalId = @Ejerskabsid)
AND (@Status IS NULL OR (
         ejerskab.status = @Status
    AND (ejende_pv.status IS NULL OR ejende_pv.status = @Status)
    AND (ejende_pv_alt_adresse.status IS NULL OR ejende_pv_alt_adresse.status = @Status)
    AND (admin_pv.status IS NULL OR admin_pv.status = @Status)
    AND (admin_pv_alt_adresse.status IS NULL OR admin_pv_alt_adresse.status = @Status)))
-- Bitemporalitet for ejerskab
[snippet_bitemp_virkning(ejerskab)]
-- Bitemporalitet for ejende person-/virkomsomhedsoplysning
[snippet_bitemp_virkning_optional(ejende_pv, objectid)]
[snippet_bitemp_virkning_optional(ejende_pv_alt_adresse, objectid)]
[snippet_bitemp_virkning_optional(ejende_pv_dar_adresse, id_lokalId)]
-- Bitemporalitet for ejende virksomhed
[snippet_bitemp_virkning_optional(ejende_virksomhed, id)]
[snippet_bitemp_virkning_optional(ejende_virksomhed_reklame_beskyttelse, CVREnhedsId)]
[snippet_bitemp_virkning_optional(ejende_virksomhed_navn, CVREnhedsId)]
[snippet_bitemp_virkning_optional(ejende_virksomhed_cvr_adresse, CVREnhedsId)]
-- Bitemporalitet for ejende person
[snippet_bitemp_virk_optional(ejende_person_personnumre, personid)]
[snippet_bitemp_virkning_cpr_optional(ejende_person, id)]
[snippet_bitemp_virk_optional(ejende_person_beskyttelse, personid)]
[snippet_bitemp_virk_optional(ejende_person_navn, personid)]
[snippet_bitemp_virk_optional(ejende_person_cpr_adresse, personid)]
[snippet_bitemp_virk_optional(ejende_person_ud_ind_rejse, personid)]
[snippet_bitemp_virkning_optional(ejende_person_dar_adresse, id_lokalId)]
-- Bitemporalitet for administrerende person-/virkomsomhedsoplysning
[snippet_bitemp_virkning_optional(admin_pv, objectid)]
[snippet_bitemp_virkning_optional(admin_pv_alt_adresse, objectid)]
[snippet_bitemp_virkning_optional(admin_pv_dar_adresse, id_lokalId)]
-- Bitemporalitet for administrerende virksomhed
[snippet_bitemp_virkning_optional(admin_virksomhed, id)]
[snippet_bitemp_virkning_optional(admin_virksomhed_reklame_beskyttelse, CVREnhedsId)]
[snippet_bitemp_virkning_optional(admin_virksomhed_navn, CVREnhedsId)]
[snippet_bitemp_virkning_optional(admin_virksomhed_cvr_adresse, CVREnhedsId)]
-- Bitemporalitet for administrerende produktionsenhed
[snippet_bitemp_virkning_optional(admin_penhed, id)]
[snippet_bitemp_virkning_optional(admin_penhed_reklame_beskyttelse, CVREnhedsId)]
[snippet_bitemp_virkning_optional(admin_penhed_navn, CVREnhedsId)]
[snippet_bitemp_virkning_optional(admin_penhed_cvr_adresse, CVREnhedsId)]
-- Bitemporalitet for administrerende person
[snippet_bitemp_virk_optional(admin_person_personnumre, personid)]
[snippet_bitemp_virkning_cpr_optional(admin_person, id)]
[snippet_bitemp_virk_optional(admin_person_beskyttelse, personid)]
[snippet_bitemp_virk_optional(admin_person_navn, personid)]
[snippet_bitemp_virk_optional(admin_person_cpr_adresse, personid)]
[snippet_bitemp_virk_optional(admin_person_ud_ind_rejse, personid)]
[snippet_bitemp_virkning_optional(admin_person_dar_adresse, id_lokalId)]
;