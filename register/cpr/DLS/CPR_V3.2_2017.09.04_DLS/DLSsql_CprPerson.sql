SELECT *
FROM PERSON
  LEFT JOIN BESKYTTELSE 	ON PERSON.id = BESKYTTELSE.personid
  LEFT JOIN PERSONNUMMER 	ON PERSON.id = PERSONNUMMER.personid
  LEFT JOIN NAVN 			ON PERSON.id = NAVN.personid
  LEFT JOIN STATSBORGERSKAB	ON PERSON.id = STATSBORGERSKAB.personid
  INNER JOIN CIVILSTAND		ON PERSON.id = CIVILSTAND.personid
    LEFT JOIN PERSON AS Aegtefaelle		ON CIVILSTAND.aegtefaelle = Aegtefaelle.id
	  LEFT JOIN NAVN AS AegtefaelleNavn ON Aegtefaelle.id = AegtefaelleNavn.personid AND AegtefaelleNavn.status='aktuel'
	  LEFT JOIN CPRADRESSE AS AegtefaelleAdr ON Aegtefaelle.id = AegtefaelleAdr.personid AND AegtefaelleAdr.status='aktuel'
	  LEFT JOIN UDREJSEINDREJSE AS AegtefaelleUdind ON Aegtefaelle.id = AegtefaelleUdind.personid AND AegtefaelleUdind.status='aktuel'
    LEFT JOIN FORSVINDING AS AegtefaelleForsv ON Aegtefaelle.id = AegtefaelleForsv.personid AND AegtefaelleAdr.status='aktuel'
    LEFT JOIN KONTAKTADRESSE AS AegtefaelleKA ON Aegtefaelle.id = AegtefaelleKA.personid AND AegtefaelleAdr.status='aktuel'
    LEFT JOIN SEPARATION 				ON CIVILSTAND.civilstandsid = SEPARATION.civilstandsid AND CIVILSTAND.personid = SEPARATION.personid
  LEFT JOIN MORFAR			ON PERSON.id = MORFAR.personid
    LEFT JOIN PERSON AS Mor				ON MORFAR.morid = Mor.id
      LEFT JOIN NAVN AS MorNavn ON Mor.id = MorNavn.personid AND MorNavn.status='aktuel'
      LEFT JOIN CPRADRESSE AS MorAdr ON Mor.id = MorAdr.personid AND MorAdr.status='aktuel'
      LEFT JOIN UDREJSEINDREJSE AS MorUdind ON Mor.id = MorUdind.personid AND MorUdind.status='aktuel'
      LEFT JOIN FORSVINDING AS MorForsv ON Mor.id = MorForsv.personid AND MorForsv.status='aktuel'
      LEFT JOIN KONTAKTADRESSE AS MorKA ON Mor.id = MorKA.personid AND MorKA.status='aktuel'
    LEFT JOIN PERSON AS Far				ON MORFAR.farid = Far.id  /* Mor UNION Far */
      LEFT JOIN NAVN AS FarNavn ON Far.id = FarNavn.personid AND FarNavn.status='aktuel'
      LEFT JOIN CPRADRESSE AS FarAdr ON Far.id = FarAdr.personid AND FarAdr.status='aktuel'
      LEFT JOIN UDREJSEINDREJSE AS FarUdind ON Far.id = FarUdind.personid AND FarUdind.status='aktuel'
      LEFT JOIN FORSVINDING AS FarForsv ON Far.id = FarForsv.personid AND FarForsv.status='aktuel'
      LEFT JOIN KONTAKTADRESSE AS FarKA ON Far.id = FarKA.personid AND FarKA.status='aktuel'
  LEFT FORAELDREMYNDIGHED	ON PERSON.id = FORAELDREMYNDIGHED.id
    LEFT JOIN MORFAR AS FM_Mor			ON FORAELDREMYNDIGHED.foraeldremyndighedshaverrolle='mor' AND PERSON.id = FM_Mor.person.id
      LEFT JOIN PERSON AS FM_Mor_P			ON FM_Mor.morid = FM_Mor_P.id
        LEFT JOIN NAVN AS FM_Mor_PNavn ON FM_Mor_P.id = FM_Mor_PNavn.personid AND FM_Mor_PNavn.status='aktuel'
        LEFT JOIN CPRADRESSE AS FM_Mor_PAdr ON FM_Mor_P.id = FM_Mor_PAdr.personid AND FM_Mor_PAdr.status='aktuel'
        LEFT JOIN UDREJSEINDREJSE AS FM_Mor_PUdind ON FM_Mor_P.id = FM_Mor_PUdind.personid AND FM_Mor_PUdind.status='aktuel'
        LEFT JOIN FORSVINDING AS FM_Mor_PForsv ON FM_Mor_P.id = FM_Mor_PForsv.personid AND FM_Mor_PForsv.status='aktuel'
        LEFT JOIN KONTAKTADRESSE AS FM_Mor_PKA ON FM_Mor_P.id = FM_Mor_PKA.personid AND FM_Mor_PKA.status='aktuel'
	  LEFT JOIN PERSONNUMMER AS FM_Mor_pnr ON MorFar.morid = FM_Mor_pnr.personid AND FM_Mor_pnr.status ='aktuel'
    LEFT JOIN MORFAR AS FM_Far			ON FORAELDREMYNDIGHED.foraeldremyndighedshaverrolle='far_medMor' AND PERSON.id = FM_Far.person.id
	    LEFT JOIN PERSON AS FM_Far_P			ON FM_Far.farid = FM_Far_P.id
        LEFT JOIN NAVN AS FM_Far_PNavn ON FM_Far_P.id = FM_Far_PNavn.personid AND FM_Far_PNavn.status='aktuel'
        LEFT JOIN CPRADRESSE AS FM_Far_PAdr ON FM_Far_P.id = FM_Far_PAdr.personid AND FM_Far_PAdr.status='aktuel'
        LEFT JOIN UDREJSEINDREJSE AS FM_Far_PUdind ON FM_Far_P.id = FM_Far_PUdind.personid AND FM_Far_PUdind.status='aktuel'
        LEFT JOIN FORSVINDING AS FM_Far_PForsv ON FM_Far_P.id = FM_Far_PForsv.personid AND FM_Far_PForsv.status='aktuel'
        LEFT JOIN KONTAKTADRESSE AS FM_Far_PKA ON FM_Far_P.id = FM_Far_PKA.personid AND FM_Far_PKA.status='aktuel'
    LEFT JOIN PERSONNUMMER AS FM_Far_pnr ON MorFar.farid = FM_Far_pnr.personid AND FM_Far_pnr.status ='aktuel'
	  LEFT JOIN PERSON AS FM_Anden		ON FORAELDREMYNDIGHED.foraeldremyndighedshaverrolle='anden' AND FORAELDREMYNDIGHED.foraeldremyndighedsindehaver = FM_Anden.person.id
        LEFT JOIN NAVN AS FM_AndenNavn ON FM_Anden.id = FM_AndenNavn.personid AND FM_AndenNavn.status='aktuel'
        LEFT JOIN CPRADRESSE AS FM_AndenAdr ON FM_Anden.id = FM_AndenAdr.personid AND FM_AndenAdr.status='aktuel'
        LEFT JOIN UDREJSEINDREJSE AS FM_AndenUdind ON FM_Anden.id = FM_AndenUdind.personid AND FM_AndenUdind.status='aktuel'
        LEFT JOIN FORSVINDING AS FM_AndenForsv ON FM_Anden.id = FM_AndenForsv.personid AND FM_AndenForsv.status='aktuel'
        LEFT JOIN KONTAKTADRESSE AS FM_AndenKA ON FM_Anden.id = FM_AndenKA.personid AND FM_AndenKA.status='aktuel'
    LEFT JOIN PERSONNUMMER AS FM_Anden_pnr ON FM_Anden.id = FM_Anden_pnr.personid AND FM_Anden_pnr.status ='aktuel'

-- Børn
  LEFT JOIN MORFAR AS Foraelder ON (PERSON.id = Foraelder.farid OR PERSON.id = Foraelder.morid)
    INNER JOIN PERSON Barn ON Foraelder.id = Barn.id
      LEFT JOIN NAVN AS BarnNavn ON Barn.id = BarnNavn.personid AND BarnNavn.status='aktuel'
      LEFT JOIN CPRADRESSE AS BarnAdr ON Barn.id = BarnAdr.personid AND BarnAdr.status='aktuel'
      LEFT JOIN UDREJSEINDREJSE AS BarnUdind ON Barn.id = BarnUdind.personid AND BarnUdind.status='aktuel'
      LEFT JOIN FORSVINDING AS BarnForsv ON Barn.id = BarnForsv.personid AND BarnForsv.status='aktuel'
      LEFT JOIN KONTAKTADRESSE AS FM_AndenKA ON Barn.id = BarnKA.personid AND BarnKA.status='aktuel'
    INNER JOIN PERSONNUMMER Barn_pnr ON Barn.id = Barn_pnr.id  AND Barn_pnr.status='aktuel'

  LEFT JOIN VAERGEMAAL 			ON PERSON.id = VAERGEMAAL.personid
  LEFT JOIN FORSVINDING			ON PERSON.id = FORSVINDING.personid
  LEFT JOIN UDREJSEINDREJSE		ON PERSON.id = UDREJSEINDREJSE.personid
  LEFT JOIN KONTAKTADRESSE AS SimpelAdresse	ON PERSON.id = SimpelAdresse.personid
  LEFT JOIN CPRADRESSE AS AdresseOplysninger	ON PERSON.id = AdresseOplysninger.personid
  LEFT JOIN KOMMUNEFORHOLD	ON PERSON.id = KOMMUNEFORHOLD.personid
  LEFT JOIN VALGOPLYSNINGER	ON PERSON.id = VALGOPLYSNINGER.personid
  LEFT JOIN FOLKEKIRKE		ON PERSON.id = FOLKEKIRKE.personid
  LEFT JOIN FLYTTEPAABUD	ON PERSON.id = FLYTTEPAABUD.personid

 WHERE
		(@person.id.eq IS NULL OR PERSON.id = @person.id.eq)
	AND ((@person.id.wi) IS NULL OR PERSON.id in (@person.id.wi))
	AND (@person.id.ne IS NULL OR PERSON.id <> @person.id.ne)
	AND (@person.id.lt IS NULL OR PERSON.id < @person.id.lt)
	AND (@person.id.le IS NULL OR PERSON.id <= @person.id.le)
	AND (@person.id.gt IS NULL OR PERSON.id > @person.id.gt)
	AND (@person.id.ge IS NULL OR PERSON.id >= @person.id.ge)

	AND (@person.status.eq IS NULL OR PERSON.status = @person.status.eq)
	AND ((@person.status.wi) IS NULL OR PERSON.status in (@person.status.wi) )

	AND (@person.stilling.eq IS NULL OR PERSON.stilling = @person.stilling.eq)
	AND ((@person.stilling.wi) IS NULL OR PERSON.stilling in (@person.stilling.wi) )
	AND (@person.stilling.cont IS NULL OR PERSON.stilling like '%' + @person.stilling.cont + '%' )

	/* registreringsaktoer and virkningsaktoer dose not exists */

	AND (@person.koen.eq IS NULL OR PERSON.koen = @person.koen.eq )
	AND ((@person.koen.wi) IS NULL OR PERSON.koen in (@person.koen.wi) )

	AND (@person.registreringfra.eq IS NULL OR PERSON.registreringfra = @person.registreringfra.eq)
	AND (@person.registreringfra.ne IS NULL OR PERSON.registreringfra <> @person.registreringfra.ne)
	AND (@person.registreringfra.lt IS NULL OR PERSON.registreringfra < @person.registreringfra.lt)
	AND (@person.registreringfra.le IS NULL OR PERSON.registreringfra <= @person.registreringfra.le)
	AND (@person.registreringfra.gt IS NULL OR PERSON.registreringfra > @person.registreringfra.gt)
	AND (@person.registreringfra.ge IS NULL OR PERSON.registreringfra >= @person.registreringfra.ge)

	AND (@person.registreringtil.eq IS NULL OR PERSON.registreringtil = @person.registreringtil.eq)
	AND (@person.registreringtil.ne IS NULL OR PERSON.registreringtil <> @person.registreringtil.ne)
	AND (@person.registreringtil.lt IS NULL OR PERSON.registreringtil < @person.registreringtil.lt)
	AND (@person.registreringtil.le IS NULL OR PERSON.registreringtil <= @person.registreringtil.le)
	AND (@person.registreringtil.gt IS NULL OR PERSON.registreringtil > @person.registreringtil.gt)
	AND (@person.registreringtil.ge IS NULL OR PERSON.registreringtil >= @person.registreringtil.ge)

	AND (@person.virkningfra.eq IS NULL OR PERSON.virkningfra = @person.virkningfra.eq)
	AND (@person.virkningfra.ne IS NULL OR PERSON.virkningfra <> @person.virkningfra.ne)
	AND (@person.virkningfra.lt IS NULL OR PERSON.virkningfra < @person.virkningfra.lt)
	AND (@person.virkningfra.le IS NULL OR PERSON.virkningfra <= @person.virkningfra.le)
	AND (@person.virkningfra.gt IS NULL OR PERSON.virkningfra > @person.virkningfra.gt)
	AND (@person.virkningfra.ge IS NULL OR PERSON.virkningfra >= @person.virkningfra.ge)

	AND (@person.virkningtil.eq IS NULL OR PERSON.virkningtil = @person.virkningtil.eq)
	AND (@person.virkningtil.ne IS NULL OR PERSON.virkningtil <> @person.virkningtil.ne)
	AND (@person.virkningtil.lt IS NULL OR PERSON.virkningtil < @person.virkningtil.lt)
	AND (@person.virkningtil.le IS NULL OR PERSON.virkningtil <= @person.virkningtil.le)
	AND (@person.virkningtil.gt IS NULL OR PERSON.virkningtil > @person.virkningtil.gt)
	AND (@person.virkningtil.ge IS NULL OR PERSON.virkningtil >= @person.virkningtil.ge)

	AND (@person.virkningfraum.eq IS NULL OR PERSON.virkningfrausikkerhedsmarkering = @person.virkningfraum.eq)
	AND (@person.virkningtilum.eq IS NULL OR PERSON.virkningtilusikkerhedsmarkering = @person.virkningtilum.eq)

	AND (@person.statusdato.eq IS NULL OR PERSON.statusdato = @person.statusdato.eq)
	AND (@person.statusdato.ne IS NULL OR PERSON.statusdato <> @person.statusdato.ne)
	AND (@person.statusdato.lt IS NULL OR PERSON.statusdato < @person.statusdato.lt)
	AND (@person.statusdato.le IS NULL OR PERSON.statusdato <= @person.statusdato.le)
	AND (@person.statusdato.gt IS NULL OR PERSON.statusdato > @person.statusdato.gt)
	AND (@person.statusdato.ge IS NULL OR PERSON.statusdato >= @person.statusdato.ge)

	AND (@person.statusdatoum.eq IS NULL OR PERSON.statusdatousikkerhedsmarkering = @person.statusdatoum.eq)

	AND (@person.foedselsdato.eq IS NULL OR PERSON.foedselsdato = @person.foedselsdato.eq)
	AND (@person.foedselsdato.ne IS NULL OR PERSON.foedselsdato <> @person.foedselsdato.ne)
	AND (@person.foedselsdato.lt IS NULL OR PERSON.foedselsdato < @person.foedselsdato.lt)
	AND (@person.foedselsdato.le IS NULL OR PERSON.foedselsdato <= @person.foedselsdato.le)
	AND (@person.foedselsdato.gt IS NULL OR PERSON.foedselsdato > @person.foedselsdato.gt)
	AND (@person.foedselsdato.ge IS NULL OR PERSON.foedselsdato >= @person.foedselsdato.ge)

	AND (@person.foedselsdatoum.eq IS NULL OR PERSON.foedselsdatousikkerhedsmarkering = @person.foedselsdatoum.eq)

	AND EXISTS (SELECT * FROM PERSONNUMMER
				WHERE PERSON.id = PERSONNUMMER.personid
				AND (@pnr.personnummer.eq IS NULL OR PERSONNUMMER.personnummer = @pnr.personnummer.eq)
				AND ((@pnr.personnummer.wi) IS NULL  OR PERSONNUMMER.personnummer in (@pnr.personnummer.wi))
				AND (@pnr.virkningfra.eq IS NULL OR PERSONNUMMER.virkningfra =  @pnr.virkningfra.eq)
				AND (@pnr.virkningfra.ne IS NULL OR PERSONNUMMER.virkningfra <> @pnr.virkningfra.ne)
				AND (@pnr.virkningfra.lt IS NULL OR PERSONNUMMER.virkningfra <  @pnr.virkningfra.lt)
				AND (@pnr.virkningfra.le IS NULL OR PERSONNUMMER.virkningfra <= @pnr.virkningfra.le)
				AND (@pnr.virkningfra.gt IS NULL OR PERSONNUMMER.virkningfra >  @pnr.virkningfra.gt)
				AND (@pnr.virkningfra.ge IS NULL OR PERSONNUMMER.virkningfra >= @pnr.virkningfra.ge)

				AND (@pnr.virkningtil.eq IS NULL OR PERSONNUMMER.virkningtil =  @pnr.virkningtil.eq)
				AND (@pnr.virkningtil.ne IS NULL OR PERSONNUMMER.virkningtil <> @pnr.virkningtil.ne)
				AND (@pnr.virkningtil.lt IS NULL OR PERSONNUMMER.virkningtil <  @pnr.virkningtil.lt)
				AND (@pnr.virkningtil.le IS NULL OR PERSONNUMMER.virkningtil <= @pnr.virkningtil.le)
				AND (@pnr.virkningtil.gt IS NULL OR PERSONNUMMER.virkningtil >  @pnr.virkningtil.gt)
				AND (@pnr.virkningtil.ge IS NULL OR PERSONNUMMER.virkningtil >= @pnr.virkningtil.ge)

				AND (@pnr.virkningfraum.eq IS NULL OR PERSONNUMMER.virkningfrausikkerhedsmarkering = @pnr.virkningfraum.eq)
				AND (@pnr.virkningtilum.eq IS NULL OR PERSONNUMMER.virkningtilusikkerhedsmarkering = @pnr.virkningtilum.eq)
				)

	AND EXISTS (SELECT * FROM FOEDSELSREGISTRERING AS FOEDREG
				WHERE PERSON.id = FOEDREG.personid
				AND (@person.supplfoedselsregsted.eq IS NULL OR FOEDREG.supplerendefoedselsregistreringssted = @person.supplfoedselsregsted.eq)
				AND ((@person.supplfoedselsregsted.wi) IS NULL OR FOEDREG.supplerendefoedselsregistreringssted in (@person.supplfoedselsregsted.wi) )
				AND (@person.supplfoedselsregsted.cont IS NULL OR FOEDREG.supplerendefoedselsregistreringssted like '%' + @person.supplfoedselsregsted.cont + '%' )
				AND ((@person.cprfoedselsregstedskode.wi) IS NULL OR FOEDREG.cprfoedselsregistreringsstedskode in (@person.cprfoedselsregstedskode.wi) )

				AND (@person.cprfoedselsregstedskode.eq IS NULL OR FOEDREG.cprfoedselsregistreringsstedskode =  @person.cprfoedselsregstedskode.eq)
				AND (@person.cprfoedselsregstedskode.ne IS NULL OR FOEDREG.cprfoedselsregistreringsstedskode <> @person.cprfoedselsregstedskode.ne)
				AND (@person.cprfoedselsregstedskode.lt IS NULL OR FOEDREG.cprfoedselsregistreringsstedskode <  @person.cprfoedselsregstedskode.lt)
				AND (@person.cprfoedselsregstedskode.le IS NULL OR FOEDREG.cprfoedselsregistreringsstedskode <= @person.cprfoedselsregstedskode.le)
				AND (@person.cprfoedselsregstedskode.gt IS NULL OR FOEDREG.cprfoedselsregistreringsstedskode >  @person.cprfoedselsregstedskode.gt)
				AND (@person.cprfoedselsregstedskode.ge IS NULL OR FOEDREG.cprfoedselsregistreringsstedskode >= @person.cprfoedselsregstedskode.ge)

				AND (@person.cprfoedselsregstedsnavn.eq IS NULL OR FOEDREG.cprfoedselsregistreringsstedsnavn = @person.cprfoedselsregstedsnavn.eq)
				AND ((@person.cprfoedselsregstedsnavn.wi) IS NULL OR FOEDREG.cprfoedselsregistreringsstedsnavn in (@person.cprfoedselsregstedsnavn.wi) )
				AND (@person.cprfoedselsregstedsnavn.cont IS NULL OR FOEDREG.cprfoedselsregistreringsstedsnavn like '%' + @person.cprfoedselsregstedsnavn.cont + '%')
				)

	AND EXISTS (SELECT * FROM NAVN
				WHERE PERSON.id = NAVN.personid
				AND (@navn.fornavne.eq IS NULL OR NAVN.fornavne = @navn.fornavne.eq)
				AND ((@navn.fornavne.wi) IS NULL OR NAVN.fornavne in (@navn.fornavne.wi))
				AND (@navn.fornavne.cont IS NULL OR NAVN.fornavne like '%' + @navn.fornavne.cont + '%')

				AND (@navn.mellemnavn.eq IS NULL OR NAVN.mellemnavn = @navn.mellemnavn.eq)
				AND ((@navn.mellemnavn.wi) IS NULL OR NAVN.mellemnavn in (@navn.mellemnavn.wi))
				AND (@navn.mellemnavn.cont IS NULL OR NAVN.mellemnavn like '%' + @navn.mellemnavn.cont + '%')

				AND (@navn.efternavn.eq IS NULL OR NAVN.efternavn = @navn.efternavn.eq)
				AND ((@navn.efternavn.wi) IS NULL OR NAVN.efternavn in (@navn.efternavn.wi))
				AND (@navn.efternavn.cont IS NULL OR NAVN.efternavn like '%' + @navn.efternavn.cont + '%')

				AND (@navn.virkningfra.eq IS NULL OR NAVN.virkningfra =  @navn.virkningfra.eq)
				AND (@navn.virkningfra.ne IS NULL OR NAVN.virkningfra <> @navn.virkningfra.ne)
				AND (@navn.virkningfra.lt IS NULL OR NAVN.virkningfra <  @navn.virkningfra.lt)
				AND (@navn.virkningfra.le IS NULL OR NAVN.virkningfra <= @navn.virkningfra.le)
				AND (@navn.virkningfra.gt IS NULL OR NAVN.virkningfra >  @navn.virkningfra.gt)
				AND (@navn.virkningfra.ge IS NULL OR NAVN.virkningfra >= @navn.virkningfra.ge)

				AND (@navn.virkningtil.eq IS NULL OR NAVN.virkningtil =  @navn.virkningtil.eq)
				AND (@navn.virkningtil.ne IS NULL OR NAVN.virkningtil <> @navn.virkningtil.ne)
				AND (@navn.virkningtil.lt IS NULL OR NAVN.virkningtil <  @navn.virkningtil.lt)
				AND (@navn.virkningtil.le IS NULL OR NAVN.virkningtil <= @navn.virkningtil.le)
				AND (@navn.virkningtil.gt IS NULL OR NAVN.virkningtil >  @navn.virkningtil.gt)
				AND (@navn.virkningtil.ge IS NULL OR NAVN.virkningtil >= @navn.virkningtil.ge)

				AND (@navn.virkningfraum.eq IS NULL OR NAVN.virkningfrausikkerhedsmarkering = @navn.virkningfraum.eq)
				AND (@navn.virkningtilum.eq IS NULL OR NAVN.virkningtilusikkerhedsmarkering = @navn.virkningtilum.eq)

				AND (@navn.adresseringsnavn.eq IS NULL OR NAVN.adresseringsnavn = @navn.adresseringsnavn.eq)
				AND ((@navn.adresseringsnavn.wi) IS NULL OR NAVN.adresseringsnavn in (@navn.adresseringsnavn.wi))
				AND (@navn.adresseringsnavn.cont IS NULL OR NAVN.adresseringsnavn like '%' + @navn.adresseringsnavn.cont + '%')

				AND (@navn.status.eq IS NULL OR NAVN.status = @navn.status.eq)
				AND ((@navn.status.wi) IS NULL OR NAVN.status in (@navn.status.wi))
				)

	AND EXISTS (SELECT * FROM BESKYTTELSE AS BESKYT
				WHERE PERSON.id = BESKYT.personid
				AND (@besk.beskyttelsestype.eq IS NULL OR BESKYT.beskyttelsestype = @besk.beskyttelsestype.eq)
				AND ((@besk.beskyttelsestype.wi) IS NULL OR BESKYT.beskyttelsestype in (@besk.beskyttelsestype.wi))

				AND (@besk.status.eq IS NULL OR BESKYT.status = @besk.status.eq)
				AND ((@besk.status.wi) IS NULL OR BESKYT.status in (@besk.status.wi) )

				AND (@besk.virkningfra.eq IS NULL OR BESKYT.virkningfra =  @besk.virkningfra.eq)
				AND (@besk.virkningfra.ne IS NULL OR BESKYT.virkningfra <> @besk.virkningfra.ne)
				AND (@besk.virkningfra.lt IS NULL OR BESKYT.virkningfra <  @besk.virkningfra.lt)
				AND (@besk.virkningfra.le IS NULL OR BESKYT.virkningfra <= @besk.virkningfra.le)
				AND (@besk.virkningfra.gt IS NULL OR BESKYT.virkningfra >  @besk.virkningfra.gt)
				AND (@besk.virkningfra.ge IS NULL OR BESKYT.virkningfra >= @besk.virkningfra.ge)

				AND (@besk.virkningtil.eq IS NULL OR BESKYT.virkningtil =  @besk.virkningtil.eq)
				AND (@besk.virkningtil.ne IS NULL OR BESKYT.virkningtil <> @besk.virkningtil.ne)
				AND (@besk.virkningtil.lt IS NULL OR BESKYT.virkningtil <  @besk.virkningtil.lt)
				AND (@besk.virkningtil.le IS NULL OR BESKYT.virkningtil <= @besk.virkningtil.le)
				AND (@besk.virkningtil.gt IS NULL OR BESKYT.virkningtil >  @besk.virkningtil.gt)
				AND (@besk.virkningtil.ge IS NULL OR BESKYT.virkningtil >= @besk.virkningtil.ge)
				)

	AND EXISTS (SELECT * FROM CIVILSTAND AS CIV
				WHERE PERSON.id = CIV.personid
				AND (@civ.civilstandstype.eq IS NULL OR CIV.civilstandstype = @civ.civilstandstype.eq)
				AND ((@civ.civilstandstype.wi) IS NULL OR CIV.civilstandstype in (@civ.civilstandstype.wi) )
				AND (@civ.civilstandstype.cont IS NULL OR CIV.civilstandstype like '%' + @civ.civilstandstype.cont + '%')
				AND (@civ.civilstandstype.ne IS NULL OR CIV.civilstandstype <> @civ.civilstandstype.ne)
				AND (@civ.status.eq IS NULL OR CIV.status = @civ.status.eq )
				AND ((@civ.status.wi) IS NULL OR CIV.status in (@civ.status.wi) )

				AND (@civ.virkningfra.eq IS NULL OR CIV.virkningfra =  @civ.virkningfra.eq)
				AND (@civ.virkningfra.ne IS NULL OR CIV.virkningfra <> @civ.virkningfra.ne)
				AND (@civ.virkningfra.lt IS NULL OR CIV.virkningfra <  @civ.virkningfra.lt)
				AND (@civ.virkningfra.le IS NULL OR CIV.virkningfra <= @civ.virkningfra.le)
				AND (@civ.virkningfra.gt IS NULL OR CIV.virkningfra >  @civ.virkningfra.gt)
				AND (@civ.virkningfra.ge IS NULL OR CIV.virkningfra >= @civ.virkningfra.ge)

				AND (@civ.virkningtil.eq IS NULL OR CIV.virkningtil =  @civ.virkningtil.eq)
				AND (@civ.virkningtil.ne IS NULL OR CIV.virkningtil <> @civ.virkningtil.ne)
				AND (@civ.virkningtil.lt IS NULL OR CIV.virkningtil <  @civ.virkningtil.lt)
				AND (@civ.virkningtil.le IS NULL OR CIV.virkningtil <= @civ.virkningtil.le)
				AND (@civ.virkningtil.gt IS NULL OR CIV.virkningtil >  @civ.virkningtil.gt)
				AND (@civ.virkningtil.ge IS NULL OR CIV.virkningtil >= @civ.virkningtil.ge)

				AND (@civ.virkningfraum.eq IS NULL OR CIV.virkningfrausikkerhedsmarkering = @civ.virkningfraum.eq)
				AND (@civ.virkningtilum.eq IS NULL OR CIV.virkningtilusikkerhedsmarkering = @civ.virkningtilum.eq)
				)

	AND EXISTS (SELECT * FROM STATSBORGERSKAB AS STAT
				WHERE PERSON.id = STAT.personid
				AND ((@stat.cprlandekode.wi) IS NULL OR STAT.cprlandekode in (@stat.cprlandekode.wi))
				AND (@stat.cprlandekode.ne IS NULL OR STAT.cprlandekode <> @stat.cprlandekode.ne)
				AND (@stat.cprlandekode.eq IS NULL OR STAT.cprlandekode =  @stat.cprlandekode.eq)
				)

	AND  EXISTS (SELECT * FROM CPRHAENDELSE AS CHAEN
				WHERE PERSON.id = CHAEN.personid
				AND (@chaen.afledtmarkering.eq IS NULL OR CHAEN.afledtmarkering = @chaen.afledtmarkering.eq)

				AND (@chaen.afleveringsdato.eq IS NULL OR CHAEN.afleveringsdato =  @chaen.afleveringsdato.eq)
				AND (@chaen.afleveringsdato.ne IS NULL OR CHAEN.afleveringsdato <> @chaen.afleveringsdato.ne)
				AND (@chaen.afleveringsdato.lt IS NULL OR CHAEN.afleveringsdato <  @chaen.afleveringsdato.lt)
				AND (@chaen.afleveringsdato.le IS NULL OR CHAEN.afleveringsdato <= @chaen.afleveringsdato.le)
				AND (@chaen.afleveringsdato.gt IS NULL OR CHAEN.afleveringsdato >  @chaen.afleveringsdato.gt)
				AND (@chaen.afleveringsdato.ge IS NULL OR CHAEN.afleveringsdato >= @chaen.afleveringsdato.ge)

				AND (@chaen.forretningshaendelse.eq IS NULL OR CHAEN.forretningshaendelse = @chaen.forretningshaendelse.eq)
				AND ((@chaen.forretningshaendelse.wi) IS NULL OR CHAEN.forretningshaendelse in (@chaen.forretningshaendelse.wi) )

				AND (@chaen.forretningsomraade.eq IS NULL OR CHAEN.forretningsomraade = @chaen.forretningsomraade.eq )
				AND ((@chaen.forretningsomraade.wi) IS NULL OR CHAEN.forretningsomraade in (@chaen.forretningsomraade.wi) )
				AND (@chaen.forretningsomraade.cont IS NULL OR CHAEN.forretningsomraade like '%' + @chaen.forretningsomraade.cont + '%')

				AND (@chaen.rettetden.eq IS NULL OR CHAEN.rettetden =  @chaen.rettetden.eq)
				AND (@chaen.rettetden.ne IS NULL OR CHAEN.rettetden <> @chaen.rettetden.ne)
				AND (@chaen.rettetden.lt IS NULL OR CHAEN.rettetden <  @chaen.rettetden.lt)
				AND (@chaen.rettetden.le IS NULL OR CHAEN.rettetden <= @chaen.rettetden.le)
				AND (@chaen.rettetden.gt IS NULL OR CHAEN.rettetden >  @chaen.rettetden.gt)
				AND (@chaen.rettetden.ge IS NULL OR CHAEN.rettetden >= @chaen.rettetden.ge)
				)
	AND  EXISTS (SELECT * FROM STATSBORGERSKAB AS STAT
				WHERE PERSON.id = STAT.personid AND NOT STAT.sys_deleted
				AND ((@stat.cprlandekode.wi) IS NULL OR STAT.cprlandekode::int in (@stat.cprlandekode.wi))

				AND (@stat.cprlandekode.eq IS NULL OR STAT.cprlandekode =  @stat.cprlandekode.eq)
				AND (@stat.cprlandekode.ne IS NULL OR STAT.cprlandekode <> @stat.cprlandekode.ne)
				AND (@stat.cprlandekode.lt IS NULL OR STAT.cprlandekode <  @stat.cprlandekode.lt)
				AND (@stat.cprlandekode.le IS NULL OR STAT.cprlandekode <= @stat.cprlandekode.le)
				AND (@stat.cprlandekode.gt IS NULL OR STAT.cprlandekode >  @stat.cprlandekode.gt)
				AND (@stat.cprlandekode.ge IS NULL OR STAT.cprlandekode >= @stat.cprlandekode.ge)

				AND (@stat.cprlandenavn.eq IS NULL OR STAT.cprlandenavn = @stat.cprlandenavn.eq)
				AND ((@stat.cprlandenavn.wi) IS NULL OR STAT.cprlandenavn in (@stat.cprlandenavn.wi) )
				AND (@stat.cprlandenavn.cont IS NULL OR STAT.cprlandenavn like '%' + @stat.cprlandenavn.cont + '%')

				AND (@stat.status.eq IS NULL OR STAT.status = @stat.status.eq)
				AND ((@stat.status.wi) IS NULL OR STAT.status in (@stat.status.wi) )

				AND (@stat.virkningfra.eq IS NULL OR STAT.virkningfra =  @stat.virkningfra.eq)
				AND (@stat.virkningfra.ne IS NULL OR STAT.virkningfra <> @stat.virkningfra.ne)
				AND (@stat.virkningfra.lt IS NULL OR STAT.virkningfra <  @stat.virkningfra.lt)
				AND (@stat.virkningfra.le IS NULL OR STAT.virkningfra <= @stat.virkningfra.le)
				AND (@stat.virkningfra.gt IS NULL OR STAT.virkningfra >  @stat.virkningfra.gt)
				AND (@stat.virkningfra.ge IS NULL OR STAT.virkningfra >= @stat.virkningfra.ge)

				AND (@stat.virkningtil.eq IS NULL OR STAT.virkningtil =  @stat.virkningtil.eq)
				AND (@stat.virkningtil.ne IS NULL OR STAT.virkningtil <> @stat.virkningtil.ne)
				AND (@stat.virkningtil.lt IS NULL OR STAT.virkningtil <  @stat.virkningtil.lt)
				AND (@stat.virkningtil.le IS NULL OR STAT.virkningtil <= @stat.virkningtil.le)
				AND (@stat.virkningtil.gt IS NULL OR STAT.virkningtil >  @stat.virkningtil.gt)
				AND (@stat.virkningtil.ge IS NULL OR STAT.virkningtil >= @stat.virkningtil.ge)

				AND (@stat.virkningfraum.eq IS NULL OR STAT.virkningfrausikkerhedsmarkering = @stat.virkningfraum.eq)
				AND (@stat.virkningtilum.eq IS NULL OR STAT.virkningtilusikkerhedsmarkering = @stat.virkningtilum.eq)
				)


	AND EXISTS (SELECT * FROM CPRADRESSE AS CADR
				WHERE PERSON.id = ADR.personid
				AND (@cadr.bygningsnummer.wi IS NULL OR ADR.bygningsnummer in (@cadr.bygningsnummer.wi))
				AND (@cadr.bygningsnummer.cont IS NULL OR ADR.bygningsnummer like (@cadr.bygningsnummer.cont))
				AND (@cadr.bygningsnummer.eq IS NULL OR ADR.bygningsnummer = @cadr.bygningsnummer.eq)
				AND ((@cadr.bynavn.wi) IS NULL OR ADR.bynavn in (@cadr.bynavn.wi) )
				AND (@cadr.bynavn.cont IS NULL OR ADR.bynavn like '%' + @cadr.bynavn.cont + '%')
				AND (@cadr.bynavn.eq IS NULL OR ADR.bynavn = @cadr.bynavn.eq)
				AND ((@cadr.cprkommunekode.wi) IS NULL OR ADR.cprkommunekode in (@cadr.cprkommunekode.wi))
				AND (@cadr.cprkommunekode.ne IS NULL OR ADR.cprkommunekode <> @cadr.cprkommunekode.ne)
				AND (@cadr.cprkommunekode.eq IS NULL OR ADR.cprkommunekode =  @cadr.cprkommunekode.eq)
				AND (@cadr.cprkommunekode.lt IS NULL OR ADR.cprkommunekode <  @cadr.cprkommunekode.lt)
				AND (@cadr.cprkommunekode.le IS NULL OR ADR.cprkommunekode <= @cadr.cprkommunekode.le)
				AND (@cadr.cprkommunekode.gt IS NULL OR ADR.cprkommunekode >  @cadr.cprkommunekode.gt)
				AND (@cadr.cprkommunekode.ge IS NULL OR ADR.cprkommunekode >= @cadr.cprkommunekode.ge)
				AND ((@cadr.cprkommunenavn.wi) IS NULL OR ADR.cprkommunenavn in (@cadr.cprkommunenavn.wi))
				AND (@cadr.cprkommunenavn.cont IS NULL OR ADR.cprkommunenavn like '%' + @cadr.cprkommunenavn.cont + '%')
				AND (@cadr.cprkommunenavn.eq IS NULL OR ADR.cprkommunenavn = @cadr.cprkommunenavn.eq)
				AND ((@cadr.cprvejkode.wi) IS NULL OR ADR.cprvejkode in (@cadr.cprvejkode.wi))
				AND (@cadr.cprvejkode.ne IS NULL OR ADR.cprvejkode <> @cadr.cprvejkode.ne)
				AND (@cadr.cprvejkode.eq IS NULL OR ADR.cprvejkode =  @cadr.cprvejkode.eq)
				AND (@cadr.cprvejkode.lt IS NULL OR ADR.cprvejkode <  @cadr.cprvejkode.lt)
				AND (@cadr.cprvejkode.le IS NULL OR ADR.cprvejkode <= @cadr.cprvejkode.le)
				AND (@cadr.cprvejkode.gt IS NULL OR ADR.cprvejkode >  @cadr.cprvejkode.gt)
				AND (@cadr.cprvejkode.ge IS NULL OR ADR.cprvejkode >= @cadr.cprvejkode.ge)
				AND ((@cadr.daradresse.wi) IS NULL OR ADR.daradresse in (@cadr.daradresse.wi) )
				AND (@cadr.daradresse.cont IS NULL OR ADR.daradresse like '%' + @cadr.daradresse.cont + '%')
				AND (@cadr.daradresse.eq IS NULL OR ADR.daradresse = @cadr.daradresse.eq )
				AND ((@cadr.etage.wi) IS NULL OR ADR.etage in (@cadr.etage.wi) )
				AND (@cadr.etage.cont IS NULL OR ADR.etage like '%' + @cadr.etage.cont + '%')
				AND (@cadr.etage.eq IS NULL OR ADR.etage = @cadr.etage.eq)
				AND ((@cadr.husnummer.wi) IS NULL OR ADR.husnummer in (@cadr.husnummer.wi))
				AND (@cadr.husnummer.cont IS NULL OR ADR.husnummer like '%' + @cadr.husnummer.cont + '%')
				AND (@cadr.husnummer.eq IS NULL OR ADR.husnummer = @cadr.husnummer.eq)
				AND ((@cadr.postdistrikt.wi) IS NULL OR ADR.postdistrikt in (@cadr.postdistrikt.wi))
				AND (@cadr.postdistrikt.cont IS NULL OR ADR.postdistrikt like '%' + @cadr.postdistrikt.cont + '%')
				AND (@cadr.postdistrikt.eq IS NULL OR ADR.postdistrikt = @cadr.postdistrikt.eq)
				AND ((@cadr.postnummer.wi) IS NULL OR ADR.postnummer in (@cadr.postnummer.wi))
				AND (@cadr.postnummer.ne IS NULL OR ADR.postnummer <> @cadr.postnummer.ne)
				AND (@cadr.postnummer.eq IS NULL OR ADR.postnummer =  @cadr.postnummer.eq)
				AND (@cadr.postnummer.lt IS NULL OR ADR.postnummer <  @cadr.postnummer.lt)
				AND (@cadr.postnummer.le IS NULL OR ADR.postnummer <= @cadr.postnummer.le)
				AND (@cadr.postnummer.gt IS NULL OR ADR.postnummer >  @cadr.postnummer.gt)
				AND (@cadr.postnummer.ge IS NULL OR ADR.postnummer >= @cadr.postnummer.ge)
				AND ((@cadr.sidedoer.wi) IS NULL OR ADR.sidedoer in (@cadr.sidedoer.wi) )
				AND (@cadr.sidedoer.cont IS NULL OR ADR.sidedoer like '%' + @cadr.sidedoer.cont + '%')
				AND (@cadr.sidedoer.eq IS NULL OR ADR.sidedoer = @cadr.sidedoer.eq)
				AND ((@cadr.vejadresseringsnavn.wi) IS NULL OR ADR.vejadresseringsnavn in (@cadr.vejadresseringsnavn.wi))
				AND (@cadr.vejadresseringsnavn.cont IS NULL OR ADR.vejadresseringsnavn like '%' + @cadr.vejadresseringsnavn.cont + '%')
				AND (@cadr.vejadresseringsnavn.eq IS NULL OR ADR.vejadresseringsnavn = @cadr.vejadresseringsnavn.eq)
				AND ((@adropl.conavn.wi) IS NULL OR ADR.conavn in (@adropl.conavn.wi))
				AND (@adropl.conavn.cont IS NULL OR ADR.conavn like '%' + @adropl.conavn.cont + '%')
				AND (@adropl.conavn.eq IS NULL OR ADR.conavn = @adropl.conavn.eq)
				AND (@adropl.fraflytningsdatokommune.ne IS NULL OR ADR.fraflytningsdatokommune <> @adropl.fraflytningsdatokommune.ne)
				AND (@adropl.fraflytningsdatokommune.eq IS NULL OR ADR.fraflytningsdatokommune =  @adropl.fraflytningsdatokommune.eq)
				AND (@adropl.fraflytningsdatokommune.lt IS NULL OR ADR.fraflytningsdatokommune <  @adropl.fraflytningsdatokommune.lt)
				AND (@adropl.fraflytningsdatokommune.le IS NULL OR ADR.fraflytningsdatokommune <= @adropl.fraflytningsdatokommune.le)
				AND (@adropl.fraflytningsdatokommune.gt IS NULL OR ADR.fraflytningsdatokommune >  @adropl.fraflytningsdatokommune.gt)
				AND (@adropl.fraflytningsdatokommune.ge IS NULL OR ADR.fraflytningsdatokommune >= @adropl.fraflytningsdatokommune.ge)
				AND (@adropl.fraflytningsdatokommuneum.eq IS NULL OR ADR.fraflytningsdatokommuneusikkerhedsmarkering = @adropl.fraflytningsdatokommuneum.eq)
				AND ((@adropl.fraflytningskommunekode.wi) IS NULL OR ADR.fraflytningskommunekode in (@adropl.fraflytningskommunekode.wi))
				AND (@adropl.fraflytningskommunekode.ne IS NULL OR ADR.fraflytningskommunekode <> @adropl.fraflytningskommunekode.ne)
				AND (@adropl.fraflytningskommunekode.eq IS NULL OR ADR.fraflytningskommunekode =  @adropl.fraflytningskommunekode.eq)
				AND (@adropl.fraflytningskommunekode.lt IS NULL OR ADR.fraflytningskommunekode <  @adropl.fraflytningskommunekode.lt)
				AND (@adropl.fraflytningskommunekode.le IS NULL OR ADR.fraflytningskommunekode <= @adropl.fraflytningskommunekode.le)
				AND (@adropl.fraflytningskommunekode.gt IS NULL OR ADR.fraflytningskommunekode >  @adropl.fraflytningskommunekode.gt)
				AND (@adropl.fraflytningskommunekode.ge IS NULL OR ADR.fraflytningskommunekode >= @adropl.fraflytningskommunekode.ge)
				AND ((@adropl.fraflytningskommunenavn.wi) IS NULL OR ADR.fraflytningskommunenavn in (@adropl.fraflytningskommunenavn.wi))
				AND (@adropl.fraflytningskommunenavn.cont IS NULL OR ADR.fraflytningskommunenavn like '%' + @adropl.fraflytningskommunenavn.cont + '%')
				AND (@adropl.fraflytningskommunenavn.eq IS NULL OR ADR.fraflytningskommunenavn = @adropl.fraflytningskommunenavn.eq)
				AND (@adropl.status.eq IS NULL OR ADR.status = @adropl.status.eq)
				AND ((@adropl.status.wi) IS NULL OR ADR.status in (@adropl.status.wi))
				AND (@adropl.suppladr.simpeladresse.cont IS NULL
					OR ADR.supplerendeadresseadresselinie1 like '%' + @adropl.suppladr.simpeladresse.cont +'%'
					OR ADR.supplerendeadresseadresselinie2 like '%' + @adropl.suppladr.simpeladresse.cont +'%'
					OR ADR.supplerendeadresseadresselinie3 like '%' + @adropl.suppladr.simpeladresse.cont +'%'
					OR ADR.supplerendeadresseadresselinie4 like '%' + @adropl.suppladr.simpeladresse.cont +'%'
					OR ADR.supplerendeadresseadresselinie5 like '%' + @adropl.suppladr.simpeladresse.cont +'%')
				AND ((@adropl.suppladr.startmyndighedskode.wi) IS NULL OR ADR.supplerendeadressevirkningframyndighedskode in (@adropl.suppladr.startmyndighedskode.wi))
				AND (@adropl.suppladr.startmyndighedskode.cont IS NULL OR ADR.supplerendeadressevirkningframyndighedskode like '%' + @adropl.suppladr.startmyndighedskode.cont + '%')
				AND (@adropl.suppladr.startmyndighedskode.eq IS NULL OR ADR.supplerendeadressevirkningframyndighedskode = @adropl.suppladr.startmyndighedskode.eq)
				AND ((@adropl.suppladr.startmyndighedsnavn.wi) IS NULL OR ADR.supplerendeadressevirkningframyndighedsnavn in (@adropl.suppladr.startmyndighedsnavn.wi))
				AND (@adropl.suppladr.startmyndighedsnavn.cont IS NULL OR ADR.supplerendeadressevirkningframyndighedsnavn like '%' + @adropl.suppladr.startmyndighedsnavn.cont + '%')
				AND (@adropl.suppladr.startmyndighedsnavn.eq IS NULL OR ADR.supplerendeadressevirkningframyndighedsnavn = @adropl.suppladr.startmyndighedsnavn.eq)
				AND (@adropl.suppladr.virkningfra.ne IS NULL OR ADR.supplerendeadressevirkningfra <> @adropl.suppladr.virkningfra.ne)
				AND (@adropl.suppladr.virkningfra.eq IS NULL OR ADR.supplerendeadressevirkningfra =  @adropl.suppladr.virkningfra.eq)
				AND (@adropl.suppladr.virkningfra.lt IS NULL OR ADR.supplerendeadressevirkningfra <  @adropl.suppladr.virkningfra.lt)
				AND (@adropl.suppladr.virkningfra.le IS NULL OR ADR.supplerendeadressevirkningfra <= @adropl.suppladr.virkningfra.le)
				AND (@adropl.suppladr.virkningfra.gt IS NULL OR ADR.supplerendeadressevirkningfra >  @adropl.suppladr.virkningfra.gt)
				AND (@adropl.suppladr.virkningfra.ge IS NULL OR ADR.supplerendeadressevirkningfra >= @adropl.suppladr.virkningfra.ge)
				AND (@adropl.suppladr.virkningtil.ne IS NULL OR ADR.supplerendeadressevirkningtil <> @adropl.suppladr.virkningtil.ne)
				AND (@adropl.suppladr.virkningtil.eq IS NULL OR ADR.supplerendeadressevirkningtil =  @adropl.suppladr.virkningtil.eq)
				AND (@adropl.suppladr.virkningtil.lt IS NULL OR ADR.supplerendeadressevirkningtil <  @adropl.suppladr.virkningtil.lt)
				AND (@adropl.suppladr.virkningtil.le IS NULL OR ADR.supplerendeadressevirkningtil <= @adropl.suppladr.virkningtil.le)
				AND (@adropl.suppladr.virkningtil.gt IS NULL OR ADR.supplerendeadressevirkningtil >  @adropl.suppladr.virkningtil.gt)
				AND (@adropl.suppladr.virkningtil.ge IS NULL OR ADR.supplerendeadressevirkningtil >= @adropl.suppladr.virkningtil.ge)
				AND (@adropl.tilflytningsdatokommune.ne IS NULL OR ADR.tilflytningsdatokommune <> @adropl.tilflytningsdatokommune.ne)
				AND (@adropl.tilflytningsdatokommune.eq IS NULL OR ADR.tilflytningsdatokommune =  @adropl.tilflytningsdatokommune.eq)
				AND (@adropl.tilflytningsdatokommune.lt IS NULL OR ADR.tilflytningsdatokommune <  @adropl.tilflytningsdatokommune.lt)
				AND (@adropl.tilflytningsdatokommune.le IS NULL OR ADR.tilflytningsdatokommune <= @adropl.tilflytningsdatokommune.le)
				AND (@adropl.tilflytningsdatokommune.gt IS NULL OR ADR.tilflytningsdatokommune >  @adropl.tilflytningsdatokommune.gt)
				AND (@adropl.tilflytningsdatokommune.ge IS NULL OR ADR.tilflytningsdatokommune >= @adropl.tilflytningsdatokommune.ge)
				AND (@adropl.tilflytningsdatokommuneum.eq IS NULL OR ADR.tilflytningsdatokommuneusikkerhedsmarkering = @adropl.tilflytningsdatokommuneum.eq)
				AND (@adropl.virkningfra.ne IS NULL OR ADR.virkningfra <> @adropl.virkningfra.ne)
				AND (@adropl.virkningfra.eq IS NULL OR ADR.virkningfra =  @adropl.virkningfra.eq)
				AND (@adropl.virkningfra.lt IS NULL OR ADR.virkningfra <  @adropl.virkningfra.lt)
				AND (@adropl.virkningfra.le IS NULL OR ADR.virkningfra <= @adropl.virkningfra.le)
				AND (@adropl.virkningfra.gt IS NULL OR ADR.virkningfra >  @adropl.virkningfra.gt)
				AND (@adropl.virkningfra.ge IS NULL OR ADR.virkningfra >= @adropl.virkningfra.ge)
				AND (@adropl.virkningtil.ne IS NULL OR ADR.virkningtil <> @adropl.virkningtil.ne)
				AND (@adropl.virkningtil.eq IS NULL OR ADR.virkningtil =  @adropl.virkningtil.eq)
				AND (@adropl.virkningtil.lt IS NULL OR ADR.virkningtil <  @adropl.virkningtil.lt)
				AND (@adropl.virkningtil.le IS NULL OR ADR.virkningtil <= @adropl.virkningtil.le)
				AND (@adropl.virkningtil.gt IS NULL OR ADR.virkningtil >  @adropl.virkningtil.gt)
				AND (@adropl.virkningtil.ge IS NULL OR ADR.virkningtil >= @adropl.virkningtil.ge)
				)
	AND EXISTS (SELECT * FROM FLYTTEPAABUD AS FLYT
				WHERE PERSON.id = FLYT.personid
				AND (@flyt.bemaerkninger.eq IS NULL OR FLYT.bemarkning = @flyt.bemaerkninger.eq)
				AND ((@flyt.bemaerkninger.wi) IS NULL OR FLYT.bemarkning in (@flyt.bemaerkninger.wi))
				AND (@flyt.bemaerkninger.cont IS NULL OR FLYT.bemarkning like '%' + @flyt.bemaerkninger.cont + '%')
				AND (@flyt.virkningfra.ne IS NULL OR FLYT.virkningfra <> @flyt.virkningfra.ne)
				AND (@flyt.virkningfra.eq IS NULL OR FLYT.virkningfra =  @flyt.virkningfra.eq)
				AND (@flyt.virkningfra.lt IS NULL OR FLYT.virkningfra <  @flyt.virkningfra.lt)
				AND (@flyt.virkningfra.le IS NULL OR FLYT.virkningfra <= @flyt.virkningfra.le)
				AND (@flyt.virkningfra.gt IS NULL OR FLYT.virkningfra >  @flyt.virkningfra.gt)
				AND (@flyt.virkningfra.ge IS NULL OR FLYT.virkningfra >= @flyt.virkningfra.ge)
				)
	AND  EXISTS (SELECT * FROM FOLKEKIRKE AS FOLK
				WHERE PERSON.id = FOLK.personid
				AND (@folk.status.eq IS NULL OR FOLK.status = @folk.status.eq)
				AND ((@folk.status.wi) IS NULL OR FOLK.status in (@folk.status.wi))
				AND (@folk.tilhoersforhold.eq IS NULL OR FOLK.tilhoersforhold = @folk.tilhoersforhold.eq)
				AND ((@folk.tilhoersforhold.wi) IS NULL OR FOLK.tilhoersforhold in (@folk.tilhoersforhold.wi))
				AND (@folk.virkningfra.ne IS NULL OR FOLK.virkningfra <> @folk.virkningfra.ne)
				AND (@folk.virkningfra.eq IS NULL OR FOLK.virkningfra =  @folk.virkningfra.eq)
				AND (@folk.virkningfra.lt IS NULL OR FOLK.virkningfra <  @folk.virkningfra.lt)
				AND (@folk.virkningfra.le IS NULL OR FOLK.virkningfra <= @folk.virkningfra.le)
				AND (@folk.virkningfra.gt IS NULL OR FOLK.virkningfra >  @folk.virkningfra.gt)
				AND (@folk.virkningfra.ge IS NULL OR FOLK.virkningfra >= @folk.virkningfra.ge)
				AND (@folk.virkningtil.ne IS NULL OR FOLK.virkningtil <> @folk.virkningtil.ne)
				AND (@folk.virkningtil.eq IS NULL OR FOLK.virkningtil =  @folk.virkningtil.eq)
				AND (@folk.virkningtil.lt IS NULL OR FOLK.virkningtil <  @folk.virkningtil.lt)
				AND (@folk.virkningtil.le IS NULL OR FOLK.virkningtil <= @folk.virkningtil.le)
				AND (@folk.virkningtil.gt IS NULL OR FOLK.virkningtil >  @folk.virkningtil.gt)
				AND (@folk.virkningtil.ge IS NULL OR FOLK.virkningtil >= @folk.virkningtil.ge)
				AND (@folk.virkningfraum.eq IS NULL OR FOLK.virkningfrausikkerhedsmarkering = @folk.virkningfraum.eq)
				AND (@folk.virkningtilum.eq IS NULL OR FOLK.virkningtilusikkerhedsmarkering = @folk.virkningtilum.eq)
				)
	AND	EXISTS (SELECT * FROM MORFAR AS FOPL
				WHERE PERSON.id = FOPL.personid
				AND ((@fopl.foraelderrolle.eq ='mor' OR 'mor' in (@fopl.foraelderrolle.wi))
					AND (FOPL.morfoedselsdato IS NOT NULL
						OR FOPL.morfoedselsdatousikkerhedsmarkering IS NOT NULL
						OR FOPL.morid IS NOT NULL
						OR FOPL.mornavn IS NOT NULL
						OR FOPL.mornavnmarkering IS NOT NULL)
					)
				AND ((@fopl.foraelderrolle.eq ='far_medmor' OR 'far_medmor' in (@fopl.foraelderrolle.wi))
					AND (FOPL.farfoedselsdato IS NOT NULL
						OR FOPL.farfoedselsdatousikkerhedsmarkering IS NOT NULL
						OR FOPL.farid IS NOT NULL
						OR FOPL.farnavn IS NOT NULL
						OR FOPL.farnavnmarkering IS NOT NULL)
					)
				)
	AND EXISTS (SELECT * FROM MORFAR AS FOPL_V
				WHERE PERSON.id = FOPL_V.personid
				AND (
						(@fopl.virkningfra.ne IS NULL OR FOPL_V.virkningfrafar <> @fopl.virkningfra.ne)
					AND (@fopl.virkningfra.eq IS NULL OR FOPL_V.virkningfrafar =  @fopl.virkningfra.eq)
					AND (@fopl.virkningfra.lt IS NULL OR FOPL_V.virkningfrafar <  @fopl.virkningfra.lt)
					AND (@fopl.virkningfra.le IS NULL OR FOPL_V.virkningfrafar <= @fopl.virkningfra.le)
					AND (@fopl.virkningfra.gt IS NULL OR FOPL_V.virkningfrafar >  @fopl.virkningfra.gt)
					AND (@fopl.virkningfra.ge IS NULL OR FOPL_V.virkningfrafar >= @fopl.virkningfra.ge)
					AND (@fopl.virkningfraum.eq IS NULL OR FOPL_V.virkningfrafarusikkerhedsmarkering = @fopl.virkningfraum.eq)
					)
				UNION ALL
				SELECT * FROM MORFAR AS FOPL_V
				WHERE PERSON.id = FOPL_V.personid
				AND (
						(@fopl.virkningfra.ne IS NULL OR FOPL_V.virkningframor <> @fopl.virkningfra.ne)
					AND (@fopl.virkningfra.eq IS NULL OR FOPL_V.virkningframor =  @fopl.virkningfra.eq)
					AND (@fopl.virkningfra.lt IS NULL OR FOPL_V.virkningframor <  @fopl.virkningfra.lt)
					AND (@fopl.virkningfra.le IS NULL OR FOPL_V.virkningframor <= @fopl.virkningfra.le)
					AND (@fopl.virkningfra.gt IS NULL OR FOPL_V.virkningframor >  @fopl.virkningfra.gt)
					AND (@fopl.virkningfra.ge IS NULL OR FOPL_V.virkningframor >= @fopl.virkningfra.ge)
					AND (@fopl.virkningfraum.eq IS NULL OR FOPL_V.virkningframorusikkerhedsmarkering = @fopl.virkningfraum.eq)
					)
				)
	AND EXISTS (SELECT * FROM FORAELDREMYNDIGHED AS FMYN
				WHERE PERSON.id = FMYN.personid
				AND (@fmyn.indehaverrolle.eq IS NULL OR CASE FMYN.foraeldremyndighedshaverrolle WHEN 'anden_1' THEN 'anden' WHEN 'anden_2' THEN 'anden' ELSE FMYN.foraeldremyndighedshaverrolle END  = @fmyn.indehaverrolle.eq)
				AND ((@fmyn.indehaverrolle.wi) IS NULL OR CASE FMYN.foraeldremyndighedshaverrolle WHEN 'anden_1' THEN 'anden' WHEN 'anden_2' THEN 'anden' ELSE FMYN.foraeldremyndighedshaverrolle END in (@fmyn.indehaverrolle.wi))
				AND (@fmyn.virkningfra.ne IS NULL OR FMYN.virkningfra <> @fmyn.virkningfra.ne)
				AND (@fmyn.virkningfra.eq IS NULL OR FMYN.virkningfra =  @fmyn.virkningfra.eq)
				AND (@fmyn.virkningfra.lt IS NULL OR FMYN.virkningfra <  @fmyn.virkningfra.lt)
				AND (@fmyn.virkningfra.le IS NULL OR FMYN.virkningfra <= @fmyn.virkningfra.le)
				AND (@fmyn.virkningfra.gt IS NULL OR FMYN.virkningfra >  @fmyn.virkningfra.gt)
				AND (@fmyn.virkningfra.ge IS NULL OR FMYN.virkningfra >= @fmyn.virkningfra.ge)
				AND (@fmyn.virkningtil.ne IS NULL OR FMYN.virkningtil <> @fmyn.virkningtil.ne)
				AND (@fmyn.virkningtil.eq IS NULL OR FMYN.virkningtil =  @fmyn.virkningtil.eq)
				AND (@fmyn.virkningtil.lt IS NULL OR FMYN.virkningtil <  @fmyn.virkningtil.lt)
				AND (@fmyn.virkningtil.le IS NULL OR FMYN.virkningtil <= @fmyn.virkningtil.le)
				AND (@fmyn.virkningtil.gt IS NULL OR FMYN.virkningtil >  @fmyn.virkningtil.gt)
				AND (@fmyn.virkningtil.ge IS NULL OR FMYN.virkningtil >= @fmyn.virkningtil.ge)
				AND (@fmyn.virkningfraum.eq IS NULL OR FMYN.virkningfrausikkerhedsmarkering = @fmyn.virkningfraum.eq)
				)

	AND EXISTS (SELECT * FROM FORSVINDING AS FORSVIND
				WHERE PERSON.id = FORSVIND.personid
				AND (@forsvind.status.eq IS NULL OR FORSVIND.status = @forsvind.status.eq)
				AND ((@forsvind.status.wi) IS NULL OR FORSVIND.status in (@forsvind.status.wi))
				AND (@forsvind.virkningfra.ne IS NULL OR FORSVIND.virkningfra <> @forsvind.virkningfra.ne)
				AND (@forsvind.virkningfra.eq IS NULL OR FORSVIND.virkningfra =  @forsvind.virkningfra.eq)
				AND (@forsvind.virkningfra.lt IS NULL OR FORSVIND.virkningfra <  @forsvind.virkningfra.lt)
				AND (@forsvind.virkningfra.le IS NULL OR FORSVIND.virkningfra <= @forsvind.virkningfra.le)
				AND (@forsvind.virkningfra.gt IS NULL OR FORSVIND.virkningfra >  @forsvind.virkningfra.gt)
				AND (@forsvind.virkningfra.ge IS NULL OR FORSVIND.virkningfra >= @forsvind.virkningfra.ge)
				AND (@forsvind.virkningtil.ne IS NULL OR FORSVIND.virkningtil <> @forsvind.virkningtil.ne)
				AND (@forsvind.virkningtil.eq IS NULL OR FORSVIND.virkningtil =  @forsvind.virkningtil.eq)
				AND (@forsvind.virkningtil.lt IS NULL OR FORSVIND.virkningtil <  @forsvind.virkningtil.lt)
				AND (@forsvind.virkningtil.le IS NULL OR FORSVIND.virkningtil <= @forsvind.virkningtil.le)
				AND (@forsvind.virkningtil.gt IS NULL OR FORSVIND.virkningtil >  @forsvind.virkningtil.gt)
				AND (@forsvind.virkningtil.ge IS NULL OR FORSVIND.virkningtil >= @forsvind.virkningtil.ge)
				AND (@forsvind.virkningfraum.eq IS NULL OR FORSVIND.virkningfrausikkerhedsmarkering = @forsvind.virkningfraum.eq)
				AND (@forsvind.virkningtilum.eq IS NULL OR FORSVIND.virkningtilusikkerhedsmarkering = @forsvind.virkningtilum.eq)
				)
	AND EXISTS (SELECT * FROM KOMMUNALEFORHOLD AS KOMFOR
				WHERE PERSON.id = KOMFOR.personid
				AND (@komfor.bemaerkninger.eq IS NULL OR KOMFOR.bemaerkning = @komfor.bemaerkninger.eq)
				AND ((@komfor.bemaerkninger.wi) IS NULL OR KOMFOR.bemaerkning in (@komfor.bemaerkninger.wi))
				AND (@komfor.bemaerkninger.cont IS NULL OR KOMFOR.bemaerkning like '%' + @komfor.bemaerkninger.cont + '%')
				AND (@komfor.kommunaleforholdskode.eq IS NULL OR KOMFOR.kommunaleforholdskode = @komfor.kommunaleforholdskode.eq)
				AND ((@komfor.kommunaleforholdskode.wi) IS NULL OR KOMFOR.kommunaleforholdskode in (@komfor.kommunaleforholdskode.wi))
				AND (@komfor.kommunaleforholdskode.cont IS NULL OR KOMFOR.kommunaleforholdskode like '%' + @komfor.kommunaleforholdskode.cont + '%')
				AND (@komfor.kommunaleforholdstype.eq IS NULL OR KOMFOR.kommunaleforholdstype = @komfor.kommunaleforholdstype.eq)
				AND ((@komfor.kommunaleforholdstype.wi) IS NULL OR KOMFOR.kommunaleforholdstype in (@komfor.kommunaleforholdstype.wi))
				AND (@komfor.virkningfra.ne IS NULL OR KOMFOR.virkningfra <> @komfor.virkningfra.ne)
				AND (@komfor.virkningfra.eq IS NULL OR KOMFOR.virkningfra =  @komfor.virkningfra.eq)
				AND (@komfor.virkningfra.lt IS NULL OR KOMFOR.virkningfra <  @komfor.virkningfra.lt)
				AND (@komfor.virkningfra.le IS NULL OR KOMFOR.virkningfra <= @komfor.virkningfra.le)
				AND (@komfor.virkningfra.gt IS NULL OR KOMFOR.virkningfra >  @komfor.virkningfra.gt)
				AND (@komfor.virkningfra.ge IS NULL OR KOMFOR.virkningfra >= @komfor.virkningfra.ge)
				AND (@komfor.virkningfraum.eq IS NULL OR KOMFOR.virkningfrausikkerhedsmarkering = @komfor.virkningfraum.eq)
				)

	/* Missing fields: startmyndighedskode, startmyndighedskodenavn .. Not relevant mail 24/3 2017. */
	AND EXISTS (SELECT * FROM KONTAKTADRESSE AS KONADR
				WHERE PERSON.id = KONADR.personid
				AND (@konadr.simpeladresse.cont IS NULL
					OR KONADR.adresselinie1 like '%' + @konadr.simpeladresse.cont +'%'
					OR KONADR.adresselinie2 like '%' + @konadr.simpeladresse.cont +'%'
					OR KONADR.adresselinie3 like '%' + @konadr.simpeladresse.cont +'%'
					OR KONADR.adresselinie4 like '%' + @konadr.simpeladresse.cont +'%'
					OR KONADR.adresselinie5 like '%' + @konadr.simpeladresse.cont +'%')
				AND (@konadr.virkningfra.ne IS NULL OR KONADR.virkningfra <> @konadr.virkningfra.ne)
				AND (@konadr.virkningfra.eq IS NULL OR KONADR.virkningfra =  @konadr.virkningfra.eq)
				AND (@konadr.virkningfra.lt IS NULL OR KONADR.virkningfra <  @konadr.virkningfra.lt)
				AND (@konadr.virkningfra.le IS NULL OR KONADR.virkningfra <= @konadr.virkningfra.le)
				AND (@konadr.virkningfra.gt IS NULL OR KONADR.virkningfra >  @konadr.virkningfra.gt)
				AND (@konadr.virkningfra.ge IS NULL OR KONADR.virkningfra >= @konadr.virkningfra.ge)
				AND (@konadr.virkningtil.ne IS NULL OR KONADR.virkningtil <> @konadr.virkningtil.ne)
				AND (@konadr.virkningtil.eq IS NULL OR KONADR.virkningtil =  @konadr.virkningtil.eq)
				AND (@konadr.virkningtil.lt IS NULL OR KONADR.virkningtil <  @konadr.virkningtil.lt)
				AND (@konadr.virkningtil.le IS NULL OR KONADR.virkningtil <= @konadr.virkningtil.le)
				AND (@konadr.virkningtil.gt IS NULL OR KONADR.virkningtil >  @konadr.virkningtil.gt)
				AND (@konadr.virkningtil.ge IS NULL OR KONADR.virkningtil >= @konadr.virkningtil.ge)
				)

	AND EXISTS (SELECT * FROM NOTAT
				WHERE PERSON.id = NOTAT.personid
				AND (@notat.notatlinie.eq IS NULL OR NOTAT.notatlinie = @notat.notatlinie.eq)
				AND ((@notat.notatlinie.wi) IS NULL OR NOTAT.notatlinie in (@notat.notatlinie.wi))
				AND (@notat.notatlinie.cont IS NULL OR NOTAT.notatlinie like '%' + @notat.notatlinie.cont + '%')
				AND ((@notat.notatnummer.wi) IS NULL OR NOTAT.notatnummer in (@notat.notatlinie.wi))
				AND (@notat.notatnummer.ne IS NULL OR NOTAT.notatnummer <> @notat.notatnummer.ne)
				AND (@notat.notatnummer.eq IS NULL OR NOTAT.notatnummer =  @notat.notatnummer.eq)
				AND (@notat.notatnummer.lt IS NULL OR NOTAT.notatnummer <  @notat.notatnummer.lt)
				AND (@notat.notatnummer.le IS NULL OR NOTAT.notatnummer <= @notat.notatnummer.le)
				AND (@notat.notatnummer.gt IS NULL OR NOTAT.notatnummer >  @notat.notatnummer.gt)
				AND (@notat.notatnummer.ge IS NULL OR NOTAT.notatnummer >= @notat.notatnummer.ge)
				AND (@notat.virkningfra.ne IS NULL OR NOTAT.virkningfra <> @notat.virkningfra.ne)
				AND (@notat.virkningfra.eq IS NULL OR NOTAT.virkningfra =  @notat.virkningfra.eq)
				AND (@notat.virkningfra.lt IS NULL OR NOTAT.virkningfra <  @notat.virkningfra.lt)
				AND (@notat.virkningfra.le IS NULL OR NOTAT.virkningfra <= @notat.virkningfra.le)
				AND (@notat.virkningfra.gt IS NULL OR NOTAT.virkningfra >  @notat.virkningfra.gt)
				AND (@notat.virkningfra.ge IS NULL OR NOTAT.virkningfra >= @notat.virkningfra.ge)
				AND (@notat.virkningtil.ne IS NULL OR NOTAT.virkningtil <> @notat.virkningtil.ne)
				AND (@notat.virkningtil.eq IS NULL OR NOTAT.virkningtil =  @notat.virkningtil.eq)
				AND (@notat.virkningtil.lt IS NULL OR NOTAT.virkningtil <  @notat.virkningtil.lt)
				AND (@notat.virkningtil.le IS NULL OR NOTAT.virkningtil <= @notat.virkningtil.le)
				AND (@notat.virkningtil.gt IS NULL OR NOTAT.virkningtil >  @notat.virkningtil.gt)
				AND (@notat.virkningtil.ge IS NULL OR NOTAT.virkningtil >= @notat.virkningtil.ge)
				)

	AND EXISTS (SELECT * FROM SEPARATION AS SEP /* HACK: Uses own separation instead of spouse sparation (they should be the same) */
				WHERE PERSON.id = SEP.personid
				AND (@sep.status.eq IS NULL OR SEP.status = @sep.status.eq)
				AND ((@sep.status.wi) IS NULL OR SEP.status in (@sep.status.wi))
				AND (@sep.virkningfra.ne IS NULL OR SEP.virkningfra <> @sep.virkningfra.ne)
				AND (@sep.virkningfra.eq IS NULL OR SEP.virkningfra =  @sep.virkningfra.eq)
				AND (@sep.virkningfra.lt IS NULL OR SEP.virkningfra <  @sep.virkningfra.lt)
				AND (@sep.virkningfra.le IS NULL OR SEP.virkningfra <= @sep.virkningfra.le)
				AND (@sep.virkningfra.gt IS NULL OR SEP.virkningfra >  @sep.virkningfra.gt)
				AND (@sep.virkningfra.ge IS NULL OR SEP.virkningfra >= @sep.virkningfra.ge)
				AND (@sep.virkningtil.ne IS NULL OR SEP.virkningtil <> @sep.virkningtil.ne)
				AND (@sep.virkningtil.eq IS NULL OR SEP.virkningtil =  @sep.virkningtil.eq)
				AND (@sep.virkningtil.lt IS NULL OR SEP.virkningtil <  @sep.virkningtil.lt)
				AND (@sep.virkningtil.le IS NULL OR SEP.virkningtil <= @sep.virkningtil.le)
				AND (@sep.virkningtil.gt IS NULL OR SEP.virkningtil >  @sep.virkningtil.gt)
				AND (@sep.virkningtil.ge IS NULL OR SEP.virkningtil >= @sep.virkningtil.ge)
				AND (@sep.virkningfraum.eq IS NULL OR SEP.virkningfrausikkerhedsmarkering = @sep.virkningfraum.eq)
				AND (@sep.virkningtilum.eq IS NULL OR SEP.virkningtilusikkerhedsmarkering = @sep.virkningtilum.eq)
				)

	AND EXISTS (SELECT * FROM VALGOPLYSNINGER AS VALG
				WHERE PERSON.id = VALG.personid
				AND (@valg.valgoplysningstype.eq IS NULL OR VALG.valgoplysningstype = @valg.valgoplysningstype.eq)
				AND ((@valg.valgoplysningstype.wi) IS NULL OR VALG.valgoplysningstype in (@valg.valgoplysningstype.wi))
				AND (@valg.valgretdato.ne IS NULL OR VALG.valgretdato <> @valg.valgretdato.ne)
				AND (@valg.valgretdato.eq IS NULL OR VALG.valgretdato =  @valg.valgretdato.eq)
				AND (@valg.valgretdato.lt IS NULL OR VALG.valgretdato <  @valg.valgretdato.lt)
				AND (@valg.valgretdato.le IS NULL OR VALG.valgretdato <= @valg.valgretdato.le)
				AND (@valg.valgretdato.gt IS NULL OR VALG.valgretdato >  @valg.valgretdato.gt)
				AND (@valg.valgretdato.ge IS NULL OR VALG.valgretdato >= @valg.valgretdato.ge)
				AND (@valg.virkningfra.ne IS NULL OR VALG.virkningfra <> @valg.virkningfra.ne)
				AND (@valg.virkningfra.eq IS NULL OR VALG.virkningfra =  @valg.virkningfra.eq)
				AND (@valg.virkningfra.lt IS NULL OR VALG.virkningfra <  @valg.virkningfra.lt)
				AND (@valg.virkningfra.le IS NULL OR VALG.virkningfra <= @valg.virkningfra.le)
				AND (@valg.virkningfra.gt IS NULL OR VALG.virkningfra >  @valg.virkningfra.gt)
				AND (@valg.virkningfra.ge IS NULL OR VALG.virkningfra >= @valg.virkningfra.ge)
				AND (@valg.virkningtil.ne IS NULL OR VALG.virkningtil <> @valg.virkningtil.ne)
				AND (@valg.virkningtil.eq IS NULL OR VALG.virkningtil =  @valg.virkningtil.eq)
				AND (@valg.virkningtil.lt IS NULL OR VALG.virkningtil <  @valg.virkningtil.lt)
				AND (@valg.virkningtil.le IS NULL OR VALG.virkningtil <= @valg.virkningtil.le)
				AND (@valg.virkningtil.gt IS NULL OR VALG.virkningtil >  @valg.virkningtil.gt)
				AND (@valg.virkningtil.ge IS NULL OR VALG.virkningtil >= @valg.virkningtil.ge)
				)
	AND  EXISTS (SELECT * FROM VAERGEMAAL AS VAERGE
				WHERE PERSON.id = VAERGE.personid
				AND (@vaerge.adresse.cont IS NULL
					OR VAERGE.adresselinie1 like '%' + @vaerge.adresse.cont +'%'
					OR VAERGE.adresselinie2 like '%' + @vaerge.adresse.cont +'%'
					OR VAERGE.adresselinie3 like '%' + @vaerge.adresse.cont +'%'
					OR VAERGE.adresselinie4 like '%' + @vaerge.adresse.cont +'%'
					OR VAERGE.adresselinie5 like '%' + @vaerge.adresse.cont +'%')
				AND (@vaerge.vaergenavn.eq IS NULL OR VAERGE.vaergenavn = @vaerge.vaergenavn.eq)
				AND ((@vaerge.vaergenavn.wi) IS NULL OR VAERGE.vaergenavn in (@vaerge.vaergenavn.wi))
				AND (@vaerge.vaergenavn.cont IS NULL OR VAERGE.vaergenavn like '%' + @vaerge.vaergenavn.cont + '%')
				AND (@vaerge.virkningfra.ne IS NULL OR VAERGE.virkningfra <> @vaerge.virkningfra.ne)
				AND (@vaerge.virkningfra.eq IS NULL OR VAERGE.virkningfra =  @vaerge.virkningfra.eq)
				AND (@vaerge.virkningfra.lt IS NULL OR VAERGE.virkningfra <  @vaerge.virkningfra.lt)
				AND (@vaerge.virkningfra.le IS NULL OR VAERGE.virkningfra <= @vaerge.virkningfra.le)
				AND (@vaerge.virkningfra.gt IS NULL OR VAERGE.virkningfra >  @vaerge.virkningfra.gt)
				AND (@vaerge.virkningfra.ge IS NULL OR VAERGE.virkningfra >= @vaerge.virkningfra.ge)
				AND (@vaerge.virkningtil.ne IS NULL OR VAERGE.virkningtil <> @vaerge.virkningtil.ne)
				AND (@vaerge.virkningtil.eq IS NULL OR VAERGE.virkningtil =  @vaerge.virkningtil.eq)
				AND (@vaerge.virkningtil.lt IS NULL OR VAERGE.virkningtil <  @vaerge.virkningtil.lt)
				AND (@vaerge.virkningtil.le IS NULL OR VAERGE.virkningtil <= @vaerge.virkningtil.le)
				AND (@vaerge.virkningtil.gt IS NULL OR VAERGE.virkningtil >  @vaerge.virkningtil.gt)
				AND (@vaerge.virkningtil.ge IS NULL OR VAERGE.virkningtil >= @vaerge.virkningtil.ge)
				AND (@vaerge.virkningfraum.eq IS NULL OR VAERGE.virkningfrausikkerhedsmarkering = @vaerge.virkningfraum.eq)
				)

	AND  EXISTS (SELECT * FROM UDREJSEINDREJSE AS UDIND
				WHERE PERSON.id = UDIND.personid
				AND ((@udind.cprlandekodeindrejse.wi) IS NULL OR UDIND.cprlandekodeindrejse in (@udind.cprlandekodeindrejse.wi))
				AND ((@udind.cprlandekodeudrejse.wi) IS NULL OR UDIND.cprlandekodeindrejse in (@udind.cprlandekodeudrejse.wi))
				AND (@udind.cprlandekodeindrejse.ne IS NULL OR UDIND.cprlandekodeindrejse <> @udind.cprlandekodeindrejse.ne)
				AND (@udind.cprlandekodeindrejse.eq IS NULL OR UDIND.cprlandekodeindrejse =  @udind.cprlandekodeindrejse.eq)
				AND (@udind.cprlandekodeindrejse.lt IS NULL OR UDIND.cprlandekodeindrejse <  @udind.cprlandekodeindrejse.lt)
				AND (@udind.cprlandekodeindrejse.le IS NULL OR UDIND.cprlandekodeindrejse <= @udind.cprlandekodeindrejse.le)
				AND (@udind.cprlandekodeindrejse.gt IS NULL OR UDIND.cprlandekodeindrejse >  @udind.cprlandekodeindrejse.gt)
				AND (@udind.cprlandekodeindrejse.ge IS NULL OR UDIND.cprlandekodeindrejse >= @udind.cprlandekodeindrejse.ge)
				AND (@udind.cprlandekodeudrejse.ne IS NULL OR UDIND.cprlandekodeudrejse <> @udind.cprlandekodeudrejse.ne)
				AND (@udind.cprlandekodeudrejse.eq IS NULL OR UDIND.cprlandekodeudrejse =  @udind.cprlandekodeudrejse.eq)
				AND (@udind.cprlandekodeudrejse.lt IS NULL OR UDIND.cprlandekodeudrejse <  @udind.cprlandekodeudrejse.lt)
				AND (@udind.cprlandekodeudrejse.le IS NULL OR UDIND.cprlandekodeudrejse <= @udind.cprlandekodeudrejse.le)
				AND (@udind.cprlandekodeudrejse.gt IS NULL OR UDIND.cprlandekodeudrejse >  @udind.cprlandekodeudrejse.gt)
				AND (@udind.cprlandekodeudrejse.ge IS NULL OR UDIND.cprlandekodeudrejse >= @udind.cprlandekodeudrejse.ge)
				AND (@udind.cprlandindrejse.eq IS NULL OR UDIND.cprlandindrejse = @udind.cprlandindrejse.eq)
				AND ((@udind.cprlandindrejse.wi) IS NULL OR UDIND.cprlandindrejse in (@udind.cprlandindrejse.wi))
				AND (@udind.cprlandindrejse.cont IS NULL OR UDIND.cprlandindrejse like '%' + @udind.cprlandindrejse.cont + '%')
				AND (@udind.cprlandudrejse.eq IS NULL OR UDIND.cprlandudrejse = @udind.cprlandudrejse.eq)
				AND ((@udind.cprlandudrejse.wi) IS NULL OR UDIND.cprlandudrejse in (@udind.cprlandudrejse.wi))
				AND (@udind.cprlandudrejse.cont IS NULL OR UDIND.cprlandudrejse like '%' + @udind.cprlandudrejse.cont + '%')
				AND (@udind.status.eq IS NULL OR UDIND.status = @udind.status.eq)
				AND ((@udind.status.wi) IS NULL OR UDIND.status in (@udind.status.wi))
				AND (@udind.udenlandsadresse.cont IS NULL
					OR UDIND.udenlandsadresselinie1 like '%' + @udind.udenlandsadresse.cont +'%'
					OR UDIND.udenlandsadresselinie2 like '%' + @udind.udenlandsadresse.cont +'%'
					OR UDIND.udenlandsadresselinie3 like '%' + @udind.udenlandsadresse.cont +'%'
					OR UDIND.udenlandsadresselinie4 like '%' + @udind.udenlandsadresse.cont +'%'
					OR UDIND.udenlandsadresselinie5 like '%' + @udind.udenlandsadresse.cont +'%')
				AND (@udind.virkningfra.ne IS NULL OR UDIND.virkningfra <> @udind.virkningfra.ne)
				AND (@udind.virkningfra.eq IS NULL OR UDIND.virkningfra =  @udind.virkningfra.eq)
				AND (@udind.virkningfra.lt IS NULL OR UDIND.virkningfra <  @udind.virkningfra.lt)
				AND (@udind.virkningfra.le IS NULL OR UDIND.virkningfra <= @udind.virkningfra.le)
				AND (@udind.virkningfra.gt IS NULL OR UDIND.virkningfra >  @udind.virkningfra.gt)
				AND (@udind.virkningfra.ge IS NULL OR UDIND.virkningfra >= @udind.virkningfra.ge)
				AND (@udind.virkningtil.ne IS NULL OR UDIND.virkningtil <> @udind.virkningtil.ne)
				AND (@udind.virkningtil.eq IS NULL OR UDIND.virkningtil =  @udind.virkningtil.eq)
				AND (@udind.virkningtil.lt IS NULL OR UDIND.virkningtil <  @udind.virkningtil.lt)
				AND (@udind.virkningtil.le IS NULL OR UDIND.virkningtil <= @udind.virkningtil.le)
				AND (@udind.virkningtil.gt IS NULL OR UDIND.virkningtil >  @udind.virkningtil.gt)
				AND (@udind.virkningtil.ge IS NULL OR UDIND.virkningtil >= @udind.virkningtil.ge)
				AND (@udind.virkningfraum.eq IS NULL OR UDIND.virkningfrausikkerhedsmarkering = @udind.virkningfraum.eq)
				AND (@udind.virkningtilum.eq IS NULL OR UDIND.virkningtilusikkerhedsmarkering = @udind.virkningtilum.eq)
				)

		/* <PersonUdenCpr (without cprnr)>  */
		AND (EXISTS (SELECT * FROM MORFAR AS PUCPR_FOPL
				WHERE PERSON.id = PUCPR_FOPL.personid
				AND 	(farnavn IS NOT NULL /* father without cpr */
						AND (@pucpr.foedselsdato.ne IS NULL OR PUCPR_FOPL.farfoedselsdato <> @pucpr.foedselsdato.ne)
						AND (@pucpr.foedselsdato.eq IS NULL OR PUCPR_FOPL.farfoedselsdato =  @pucpr.foedselsdato.eq)
						AND (@pucpr.foedselsdato.lt IS NULL OR PUCPR_FOPL.farfoedselsdato <  @pucpr.foedselsdato.lt)
						AND (@pucpr.foedselsdato.le IS NULL OR PUCPR_FOPL.farfoedselsdato <= @pucpr.foedselsdato.le)
						AND (@pucpr.foedselsdato.gt IS NULL OR PUCPR_FOPL.farfoedselsdato >  @pucpr.foedselsdato.gt)
						AND (@pucpr.foedselsdato.ge IS NULL OR PUCPR_FOPL.farfoedselsdato >= @pucpr.foedselsdato.ge)
						AND (@pucpr.foedselsdatoum.eq IS NULL OR PUCPR_FOPL.farfoedselsdatousikkerhedsmarkering = @pucpr.foedselsdatoum.eq)
						AND ((@pucpr.navnemarkering.wi) IS NULL OR PUCPR_FOPL.farnavnmarkering in (@pucpr.navnemarkering.wi))
						AND (@pucpr.navn.eq IS NULL OR PUCPR_FOPL.farnavn = @pucpr.navn.eq)
						AND ((@pucpr.navn.wi) IS NULL OR PUCPR_FOPL.farnavn in (@pucpr.navn.wi))
						AND (@pucpr.navn.cont IS NULL OR PUCPR_FOPL.farnavn like '%' + @pucpr.navn.cont + '%')
						)
				UNION ALL
				SELECT * FROM MORFAR AS PUCPR_FOPL
				WHERE PERSON.id = PUCPR_FOPL.personid
				AND 	(mornavn IS NOT NULL /* mother without cpr */
						AND (@pucpr.foedselsdato.ne IS NULL OR PUCPR_FOPL.morfoedselsdato <> @pucpr.foedselsdato.ne)
						AND (@pucpr.foedselsdato.eq IS NULL OR PUCPR_FOPL.morfoedselsdato =  @pucpr.foedselsdato.eq)
						AND (@pucpr.foedselsdato.lt IS NULL OR PUCPR_FOPL.morfoedselsdato <  @pucpr.foedselsdato.lt)
						AND (@pucpr.foedselsdato.le IS NULL OR PUCPR_FOPL.morfoedselsdato <= @pucpr.foedselsdato.le)
						AND (@pucpr.foedselsdato.gt IS NULL OR PUCPR_FOPL.morfoedselsdato >  @pucpr.foedselsdato.gt)
						AND (@pucpr.foedselsdato.ge IS NULL OR PUCPR_FOPL.morfoedselsdato >= @pucpr.foedselsdato.ge)
						AND (@pucpr.foedselsdatoum.eq IS NULL OR PUCPR_FOPL.morfoedselsdatousikkerhedsmarkering = @pucpr.foedselsdatoum.eq)
						AND ((@pucpr.navnemarkering.wi) IS NULL OR PUCPR_FOPL.mornavnmarkering in (@pucpr.navnemarkering.wi))
						AND (@pucpr.navn.eq IS NULL OR PUCPR_FOPL.mornavn = @pucpr.navn.eq)
						AND ((@pucpr.navn.wi) IS NULL OR PUCPR_FOPL.mornavn in (@pucpr.navn.wi))
						AND (@pucpr.navn.cont IS NULL OR PUCPR_FOPL.mornavn like '%' + @pucpr.navn.cont + '%')
						)
				)
			OR EXISTS (SELECT * FROM CIVILSTAND AS PUCPR_CIV
				WHERE PERSON.id = PUCPR_CIV.personid
				AND
					(aegtefaellenavn IS NOT NULL /* spouse without cpr */
					AND (@pucpr.foedselsdato.ne IS NULL OR PUCPR_FOPL.aegtefaellefoedselsdato <> @pucpr.foedselsdato.ne)
					AND (@pucpr.foedselsdato.eq IS NULL OR PUCPR_FOPL.aegtefaellefoedselsdato =  @pucpr.foedselsdato.eq)
					AND (@pucpr.foedselsdato.lt IS NULL OR PUCPR_FOPL.aegtefaellefoedselsdato <  @pucpr.foedselsdato.lt)
					AND (@pucpr.foedselsdato.le IS NULL OR PUCPR_FOPL.aegtefaellefoedselsdato <= @pucpr.foedselsdato.le)
					AND (@pucpr.foedselsdato.gt IS NULL OR PUCPR_FOPL.aegtefaellefoedselsdato >  @pucpr.foedselsdato.gt)
					AND (@pucpr.foedselsdato.ge IS NULL OR PUCPR_FOPL.aegtefaellefoedselsdato >= @pucpr.foedselsdato.ge)
					AND (@pucpr.foedselsdatoum.eq IS NULL OR PUCPR_CIV.aegtefaellefoedselsdatousikkerhedsmarkering = @pucpr.foedselsdatoum.eq)
					AND ((@pucpr.navnemarkering.wi) IS NULL OR PUCPR_CIV.aegtefaellenavnemarkering in (@pucpr.navnemarkering.wi))
					AND (@pucpr.navn.eq IS NULL OR PUCPR_CIV.aegtefaellenavn = @pucpr.navn.eq)
					AND ((@pucpr.navn.wi) IS NULL OR PUCPR_CIV.aegtefaellenavn in (@pucpr.navn.wi))
					AND (@pucpr.navn.cont IS NULL OR PUCPR_CIV.aegtefaellenavn like '%' + @pucpr.navn.cont + '%')
					)
				)
			)
		/* </PersonUdenCpr (without cprnr)>  */
