WITH bfenumre AS
{
	SELECT sfe.ID_LOKALID AS BFENUMMER, sfe.STATUS, sfe.SENESTESAGLOKALID
	FROM SAMLETFASTEJENDOM sfe
	WHERE
	[snippet_bitemp_full_with_period(sfe)]
	UNION ALL
	SELECT ejl.ID_LOKALID AS BFENUMMER, ejl.STATUS, ejl.SENESTESAGLOKALID
	FROM EJERLEJLIGHED ejl
	WHERE
	[snippet_bitemp_full_with_period(ejl)]
	UNION ALL
	SELECT bpfgf.ID_LOKALID AS BFENUMMER, bpfgf.STATUS, bpfgf.SENESTESAGLOKALID
	FROM BYGNINGPAAFREMMEDGRUNDFLADE bpfgf
	WHERE
	[snippet_bitemp_full_with_period(bpfgf)]
	UNION ALL
	SELECT bpfgp.ID_LOKALID AS BFENUMMER, bpfgp.STATUS, bpfgp.SENESTESAGLOKALID
	FROM INNER JOIN BYGNINGPAAFREMMEDGRUNDPUNKT bpfgp
	WHERE
	[snippet_bitemp_full_with_period(bpfgp)]
}
SELECT sag.*, bfenumre.*
FROM FROM MATRIKULAERSAG sag
LEFT JOIN bfenumre bfe ON bfe.SENESTESAGLOKALID = sag.ID_LOKALID
--Sørg for at en gyldig kombination af inputs er givet
WHERE (@SagsId IS NOT NULL OR @Journalnr IS NOT NULL OR (@SagsKategori IS NOT NULL AND @Kommunenavn IS NOT NULL) OR (@SagsOperation IS NOT NULL AND @RekvirentRef IS NOT NULL))
AND ((@SagsKategori IS NULL AND @Kommunenavn IS NULL) OR (@SagsKategori IS NOT NULL AND @Kommunenavn IS NOT NULL))
AND ((@SagsOperation IS NULL AND @RekvirentRef IS NULL) OR (@SagsOperation IS NOT NULL AND @RekvirentRef IS NOT NULL))

--Filtrer på inputs
AND (@Status IS NULL OR sag.STATUS = @Status)
AND (@SagsId IS NULL OR sag.ID_LOKALID = @SagsId)
AND (@Journalnr IS NULL OR sag.MATRIKELMYNDIGHEDENSJOURNALNUM = @Journalnr)
AND ((@SagsKategori IS NULL OR sag.FORRETNINGSPROCES = @SagsKategori) AND (@Kommunenavn IS NULL OR LOWER(sag.KOMMUNE) LIKE LOWER(%@Kommunenavn%))) --Wildcard på begge sider af input fx '%Roskil%' vil give Roskilde Kommune
AND ((@SagsOperation IS NULL OR LOWER(sag.FORRETNINGSHAENDELSE) LIKE LOWER(%@SagsOperation%)) AND (@RekvirentRef IS NULL OR sag.REKVIRENTREF = @RekvirentRef)) --Wildcard på begge sider af input for SagsOperation