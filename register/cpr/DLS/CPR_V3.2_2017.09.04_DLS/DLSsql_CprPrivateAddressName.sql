/* Generelt Adressebeskyttelsescheck, skal bruges alle steder hvor der er kommentar = /*ADRESSEBESKYTTELSECHECK*/  */
AS TABEL INNER JOIN TABEL.personid not in (SELECT BESKYTTELSE.personid FROM BESKYTTELSE WHERE BESKYTTELSE.personid = TABEL.personid
					   AND BESKYTTELSE.beskyttelsestype='navne_og_adresse' 
					   AND CURRENT_TIMESTAMP >= BESKYTTELSE.virkningfra 
					   AND (CURRENT_TIMESTAMP <= BESKYTTELSE.virkningtil OR BESKYTTELSE.virkningtil is null)
					   AND BESKYTTELSE.status = 'aktuel')

/* PseudoSQL til CprPrivate alle metoder samlet i en */
SELECT 
	BESKYTTELSE.*,
	PERSONNUMMER.*,	-- Protection (BESKYTTELSE) of name and address in JOIN
	NAVN.*,			-- Protection (BESKYTTELSE) of name and address in JOIN
	VAERGEMAAL.*,
	Adresse.*, 		-- Protection (BESKYTTELSE) of name and address in JOIN
	UDREJSEINDREJSE.*,	-- Protection (BESKYTTELSE) of name and address in JOIN
	KONTAKTADRESSE.*,	-- Må gerne vises også selvom personen har navne_og_adresse beskyttelse, men kun for personer med status in ('udrejst','forsvundet','doed')
FROM PERSON 
  LEFT JOIN BESKYTTELSE 	ON PERSON.id = BESKYTTELSE.personid AND CURRENT_TIMESTAMP <= BESKYTTELSE.virkningtil
  LEFT JOIN PERSONNUMMER 	ON (@personnummer IS NOT NULL AND -- Only if personnummer parameter is pressent. May the personnummer be returned 
								PERSON.id = PERSONNUMMER.personid AND PERSONNUMMER.status = 'aktuel') 
  LEFT JOIN NAVN 			ON PERSON.id = NAVN.personid 
								/* ADRESSEBESKYTTELSECHECK */
								and NAVN.status = 'aktuel'
  LEFT JOIN VAERGEMAAL 			ON PERSON.id = VAERGEMAAL.personid -- No protection (BESKYTTELSE) of name and address for VAERGEMAAL
									AND (VAERGEMAAL.virkningtil IS NULL OR CURRENT_TIMESTAMP <= VAERGEMAAL.virkningtil)
  LEFT JOIN UDREJSEINDREJSE		ON PERSON.id = UDREJSEINDREJSE.personid
  								/* ADRESSEBESKYTTELSECHECK */
								and UDREJSEINDREJSE.status = 'aktuel'
/* Kontaktadresse må godt vises selvom der er adressebeskyttelse, men må ikke vises med mindre personen er død, forsvundet eller udrejst
  LEFT JOIN KONTAKTADRESSE AS SimpelAdresse	ON PERSON.id = SimpelAdresse.personid 
  								and SimpelAdresse.status = 'aktuel' and PERSON.status in ('doed','forsvundet','udrejst')
  /*Enten dansk adresse eller udrejst*/ 
  	Case When person.status = 'doed'  /* Person is dead */
  /* FORSVINDING som adrsse (kun dato) skal med i CASE (tom "record") */
	  Begin
		/* Logic for fetching adresse for a person who has been declared dead*/
		LEFT OUTER JOIN 
		   ((select top 1 from 
				(SELECT  personid, conavn, bygningsnummer, bynavn, cprKommunekode, cprKommunenavn, cprVejkode, etage, husnummer, 
						postdistrikt, postnummer, sidedoer, vejadresseringsnavn,darAdresse, NULL AS 'cprLandekodeUdrejse', 
						NULL AS 'cprLandUdrejse',NULL AS 'udenlandsadresselinie1', NULL AS 'udenlandsadresselinie2', 
						NULL AS 'udenlandsadresselinie3', NULL AS 'udenlandsadresselinie4', NULL AS 'udenlandsadresselinie5' 
				FROM cpradresse
				WHERE cpradresse.status = 'historisk'
				order by virkningfra desc               
				UNION
				SELECT personid, NULL AS 'conavn', NULL AS 'bygningsnummer', NULL AS 'bynavn', NULL AS 'cprKommunekode', 
						NULL AS 'cprKommunenavn', NULL AS 'cprVejkode', NULL AS 'etage', NULL AS 'husnummer', 
						NULL AS 'postdistrikt', NULL AS 'postnummer', NULL AS 'sidedoer', 
						NULL AS 'vejadresseringsnavn', NULL AS 'darAdresse', cprLandekodeUdrejse, cprLandUdrejse, 
						udenlandsadresselinie1, udenlandsadresselinie2, udenlandsadresselinie3, 
						udenlandsadresselinie4,  udenlandsadresselinie5
				FROM UdrejseIndrejse
				WHERE udrejseIndrejse.status = 'historisk' order by virkningfra desc)
						as ophold ON ophold.personid = Person.id
			) AS DOED_ADRESSE /* ADRESSEBESKYTTELSECHECK */
			)
      End
	else /* Person has NOT been declared dead */
	  Begin
		-- Logik til fremsøgning af eventuel aktuel adresse / Bør vel være alle adresser -> det er med historik!
		LEFT OUTER JOIN 
			((SELECT personid, conavn, bygningsnummer, bynavn, cprKommunekode, cprKommunenavn, cprVejkode, etage, 
					husnummer, postdistrikt, postnummer, sidedoer, vejadresseringsnavn,darAdresse, 
					NULL AS 'cprLandekodeUdrejse', NULL AS 'cprLandUdrejse', NULL AS 'udenlandsadresselinie1', 
					NULL AS 'udenlandsadresselinie2', NULL AS 'udenlandsadresselinie3', 
					NULL AS 'udenlandsadresselinie4', NULL AS 'udenlandsadresselinie5' 
			FROM cpradresse
			WHERE cpradresse.status = 'aktuel'
			UNION
			SELECT personid, NULL AS 'conavn', NULL AS 'bygningsnummer',NULL AS 'bynavn',NULL AS 'cprKommunekode', 
					NULL AS 'cprKommunenavn', NULL AS 'cprVejkode', NULL AS 'etage', NULL AS 'husnummer', 
					NULL AS 'postdistrikt', NULL AS 'postnummer', NULL AS 'sidedoer', NULL AS 'vejadresseringsnavn', 
					NULL AS 'darAdresse', cprLandekodeUdrejse, cprLandUdrejse, udenlandsadresselinie1, udenlandsadresselinie2,  
					udenlandsadresselinie3, udenlandsadresselinie4, udenlandsadresselinie5
			FROM UdrejseIndrejse
			WHERE status = 'aktuel')
			) AS ALTUEL_ADRESSE /*ADRESSEBESKYTTELSECHECK*/ )
			)
		as ophold ON ophold.personid = Person.id
	  End 
	/*End Case*/ AS Adresse

 WHERE /* Parameters Not final */
    -- Valid input parameters 

	PERSON.status <> 'nedlagt' AND

[For komplet forretningslogik : Se Bilag 23 - Afsnittet Private Tjenester- Søgning på navne]
	/* Anvendes i søgning med fødselsdato og navn : CprPrivateDateOfBirthName og søgning på adresse og navn : CprPrivateAdressName */
	(@Fornavne IS NOT NULL) AND @Efternavn IS NOT NULL	
   	(SELECT personid FROM NAVN WHERE 
			        NAVN.efternavn = @Efternavn AND 
				    (@Fornavne IS NULL OR NAVN.fornavne = @Fornavne) OR 
				    (NAVN.mellemnavn = @fornavn)
	)
[For komplet forretningslogik : Se Bilag 23 - Afsnittet Private Tjenester- Søgning på adresser]

	/* Anvendes i søgning med adresse og navn : CprPrivateAddressName */
	((@Vejnavn IS NOT NULL AND @Postnummer IS nOT NULL AND (@Husnummer is not NULL or @Bygningsnr is not null)) /* see validation rules */
	    OR  PERSON.id IN
		        (SELECT personid FROM CPRADRESSE WHERE
				    (CPRADRESSE.postnummer   = @Postnummer) AND 
				    (CPRADRESSE.cprvejnavn = @Vejnavn) AND 
				    (@Husnummer IS NULL OR CPRADRESSE.husnummer = @Husnummer) AND 
				    (@etage IS NULL OR CPRADRESSE.etage = @etage) AND
				    (@sidedoer IS NULL OR CPRADRESSE.sidedoer = @sidedoer) AND
				    (@Bygningsnr IS NULL OR CPRADRESSE.bygningsnummer = @Bygningsnr) 
				)
	    )


-- CPR Loven:


§ 38. Aktieselskaber, anpartsselskaber, fonde, virksomheder og andre juridiske personer samt fysiske personer, der driver erhvervsvirksomhed, har ret til efter bestemmelserne i denne paragraf og i § 40 af Økonomi- og Indenrigsministeriet at få leveret oplysninger i CPR om en større afgrænset kreds af personer, som de pågældende forud har identificeret enkeltvis, jf. stk. 5. For foreninger er det tillige en betingelse, at de har et anerkendelsesværdigt formål.

Stk. 2. Oplysningerne, der kan videregives efter stk. 1, er

1) nuværende navn, medmindre dette er beskyttet, jf. § 28,

2) nuværende adresse, medmindre denne er beskyttet, jf. § 28, og datoen for flytningen hertil,

3) eventuel stilling,

4) eventuel markering af, at den pågældende frabeder sig henvendelser, der sker i markedsføringsøjemed, jf. § 29, stk. 3,

5) eventuel død, datoen for dødsfaldet og afdødes daværende adresse, medmindre denne er beskyttet, jf. § 28,

6) eventuel forsvinden og datoen herfor,

7) eventuel udrejse og datoen herfor, eventuel ny adresse i udlandet, medmindre denne er beskyttet, jf. § 28, og datoen herfor,

8) eventuel kontaktadresse og datoen herfor og

9) eventuelt værgemål efter værgemålslovens § 6, datoen herfor og værgens navn og adresse eller

10) løbende ændringer i de i nr. 1-9 nævnte data.

Stk. 3. Forsikringsselskaber og pensionskasser omfattet af lov om finansiel virksomhed samt pengeinstitutter ved administration af opsparing i pensionsøjemed i henhold til lov om finansiel virksomhed, har, ud over oplysningerne i stk. 2, ret til at få leveret oplysninger om civilstand og civilstandsdato, bortset fra oplysning om separation, samt ved registrering i CPR af vedkommendes død tillige oplysning om navn og adresse på afdødes ægtefælle eller registrerede partner, medmindre der er registreret beskyttelse af navn og adresse efter § 28.

Stk. 4. Kreditoplysningsbureauer, som Datatilsynet har meddelt tilladelse til kreditoplysningsvirksomhed, har ret til at få oplyst navn og adresse fra CPR, uanset om disse er beskyttede efter § 28.

Stk. 5. Identifikationen af de enkelte personer efter stk. 1-4 skal ske ved enten

1) personnummer,

2) fødselsdato og navn (nuværende eller tidligere) eller

3) adresse (nuværende eller tidligere) og navn (nuværende eller tidligere).

Stk. 6. Det er en betingelse for levering af oplysninger efter stk. 1-4, at modtageren efter lov om behandling af personoplysninger er berettiget til at behandle oplysningerne.

