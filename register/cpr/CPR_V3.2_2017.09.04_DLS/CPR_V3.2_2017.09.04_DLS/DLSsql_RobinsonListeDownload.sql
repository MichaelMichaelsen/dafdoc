SELECT *
FROM PERSON
  INNER JOIN BESKYTTELSE 	ON (PERSON.id = BESKYTTELSE.personid AND BESKYTTELSE.status = 'aktuel' AND BESKYTTELSE.beskyttelsestype='markedsfoering')
  INNER JOIN PERSONNUMMER 	ON (PERSON.id = PERSONNUMMER.personid AND PERSONNUMMER.status='aktuel')
  LEFT JOIN NAVN 			ON (PERSON.id = NAVN.personid and NAVN.status='aktuel')

  -- Døde, udrejste og forsvundne skal have senest kendte historiske adresse, med mindre statusdato er over 3 år siden
  Case When person.status in ('doed','udrejst', 'forsvundet')  /* Person has no actual danish adress */
    Begin
		/* Logic for fetching adresse for a person who has been declared dead, disappeared or left the country*/
		INNER JOIN
		   ((select top 1 from
				(SELECT  personid, conavn, bygningsnummer, bynavn, cprKommunekode, cprKommunenavn, cprVejkode, etage, husnummer,
						postdistrikt, postnummer, sidedoer, vejadresseringsnavn,darAdresse
				FROM cpradresse
				WHERE cpradresse.status = 'historisk'
				AND cpradresse.cprkommunekode >= 101 and cpradresse.cprkommunekode <= 861 and cpradresse.vejkode < 9900
				AND cpradresse.personid = PERSON.id
				order by virkningfra desc )
				-- Personen skal kun med ud hvis de er udrejst, forsvundet eller døde inden for de sidste 3 år
				as ophold ON (ophold.personid = PERSON.id  AND PERSON.statusdato>= (current_timestamp - interval (3 years))  ))
				AS DOED_ADRESSE
			)
      End
	else /* Person has NOT been declared dead, disappeared or left the country */
	  Begin
		-- Logik til fremsøgning af eventuel aktuel adresse
		INNER JOIN
			(SELECT personid, conavn, bygningsnummer, bynavn, cprKommunekode, cprKommunenavn, cprVejkode, etage,
					husnummer, postdistrikt, postnummer, sidedoer, vejadresseringsnavn,darAdresse
			FROM cpradresse
			WHERE cpradresse.status = 'aktuel'
			AND cpradresse.cprkommunekode >= 101 and cpradresse.cprkommunekode <= 861 and cpradresse.vejkode < 9900
			AND cpradresse.personid = PERSON.id
			AND cpradresse.personid = PERSON.id)
			as ophold ON (ophold.personid = PERSON.id ) as AKTUEL_ADRESSE
		End
		/*End Case*/ AS Adresse
WHERE
  -- Person må ikke have aktuel navne og adresse beskyttelse
  NOT EXISTS ( SELECT BESKYTTELSE from BESKYTTELSE INNER JOIN PERSON ON (PERSON.id = BESKYTTELSE.personid and
  BESKYTTELSE.status = 'aktuel' AND BESKYTTELSE.beskyttelsestype='navne_og_adresse'))
  AND PERSON.status NOT IN ('nedlagt', 'ej_bopael', 'annulleret')

