SELECT admin.* 
FROM PersonEllerVirksomhedsadmini admin
INNER JOIN (
	(SELECT 
		NULL AS FIKTIVADMIN,
		pv.ID_LOKALID AS FIKTIVEJER,
		NULL AS VIRKSOMADMIN,
		NULL AS VIRKSOMEJER,
		NULL AS PERSONEJER,
		NULL AS PERSONADMIN,
		NULL AS PENHEDADMIN
	FROM PersonVirksomhedsoplys pv 

	--Sørg for at en gyldig kombination af inputs er givet
	WHERE (@Kommunekode IS NOT NULL)

	--Filtrer på inputs
	AND (pv.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)

	-- Bitemporalitet
	[snippet_bitemp_full_with_period(pv)]
	)
	UNION
	(SELECT 
		ejerskab.ADMINISTRATOROPLYSLOKALID AS FIKTIVADMIN,
		ejerskab.EJEROPLYSNINGERLOKALID AS FIKTIVEJER,
		ejerskab.ADMINISTRERENDEVIRKSOMHEDCVRNR AS VIRKSOMADMIN,
		ejerskab.EJENDEVIRKSOMHEDCVRNR AS VIRKSOMEJER,
		ejerskab.EJENDEPERSONPERSONNR AS PERSONEJER,
		ejerskab.ADMINISTRERENDEPERSONPERSONNR AS PERSONADMIN,
		ejerskab.PRODUKTIONSENHEDPNR AS PENHEDADMIN
	FROM Ejerskab ejerskab
	INNER JOIN EBR.EJENDOMSBELIGGENHED eb ON ejerskab.BESTEMTFASTEJENDOMBFENR = eb.BESTEMTFASTEJENDOMBFENR

	--Sørg for at en gyldig kombination af inputs er givet
	WHERE (@Kommunekode IS NOT NULL)
	
	--Filtrer på inputs
	AND (eb.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)
	
	-- Bitemporalitet
	[snippet_bitemp_full_with_period(ejerskab)]
	[snippet_bitemp_full_now(eb)]
	)
	UNION
	
	(SELECT 
		PERSONELLERVIRKSOMHEDLOKALID AS FIKTIVADMIN,
		NULL AS FIKTIVEJER,
		VIRKSOMHEDCVRNR AS VIRKSOMADMIN,
		NULL AS VIRKSOMEJER,
		NULL AS PERSONEJER,
		PERSONPERSONNR AS PERSONADMIN,
		PRODUKTIONSENHEDPNR AS PENHEDADMIN
	FROM Ejendomsadministrator ejdmadmin
	INNER JOIN EBR.EJENDOMSBELIGGENHED eb ON ejdmadmin.BESTEMTFASTEJENDOMBFENR = eb.BESTEMTFASTEJENDOMBFENR
	
	--Sørg for at en gyldig kombination af inputs er givet
	WHERE (@Kommunekode IS NOT NULL)
	
	--Filtrer på inputs
	AND (eb.KOMMUNEINDDELINGKOMMUNEKODE = @Kommunekode)
	
	-- Bitemporalitet
	[snippet_bitemp_full_with_period(ejdmadmin)]
	[snippet_bitemp_full_now(eb)]
	)
) kb ON 
	admin.PERSONVIRKSOMOPLLOKALID = kb.FIKTIVADMIN OR
	admin.PERSONVIRKSOMOPLLOKALID = kb.FIKTIVEJER OR
	admin.ADMINISTRERETVIRKSOMCVRNR = kb.VIRKSOMEJER OR
	admin.ADMINISTRERETVIRKSOMCVRNR = kb.VIRKSOMADMIN OR
	admin.ADMINISTRERETPERSONPERSONNR = kb.PERSONEJER OR
	admin.ADMINISTRERETPERSONPERSONNR = kb.PERSONADMIN

WHERE (@Status IS NULL OR admin.status = @Status)

[snippet_bitemp_full_with_period(admin)]
;