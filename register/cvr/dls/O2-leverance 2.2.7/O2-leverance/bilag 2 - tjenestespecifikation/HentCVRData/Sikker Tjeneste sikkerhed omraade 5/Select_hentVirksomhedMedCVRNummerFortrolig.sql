SELECT 
CVRE.id,					/*description": "EAID_A09EF54A_A9A3_413b_94C2_805EFA701A52"*/
v.status,
v.CVRNummer,
n.vaerdi,					/*description": "EAID_AE8C2560_67DF_41e3_98D3_AD8500846E9B",*/
v.virksomhedStartdato,		/*"description": "EAID_0315F5E1_1610_44da_83F8_6BFE523C3B3C"*/
v.virkningFra,				/*"description": "EAID_DF8A413C_A35D_4a7d_B61C_0B836F8E6C22"*/
v.virkningTil,				/*"description": "EAID_7B6826FD_9124_47aa_96D5_CFB39C172311"*/
R.vaerdi,
AD.vaerdi,
e.vaerdi,
t.vaerdi,
f.vaerdi,
f.vaerdiTekst,
k.statusvaerdi,
k.statusvaerdiTekst,
k.Kreditoplysning,
k.KreditoplysningsTekst,
ap.Adresse,					/*DAR UUID*/
ap.AdresseringAndvendelse,
ap.CVRAdresse_vejkode,
ap.CVRAdresse_husnummerFra,
ap.CVRAdresse_etagebetegnelse,
ap.CVRAdresse_doerbetegnelse,
ap.CVRAdresse_kommunekode,
ap.CVRAdresse_kommunenavn,
ap.CVRAdresse_postdistrikt,
ap.CVRAdresse_vejnavn,
ap.CVRAdresse_husnummerTil,
ap.CVRAdresse_postnummer,
ap.CVRAdresse_supplerendeBynavn,
ap.CVRAdresse_adresseFritekst,
ap.CVRAdresse_landekode,
ap.coNavn,
ab.Adresse,					/*DAR UUID*/
ap.AdresseringAndvendelse,
ab.CVRAdresse_vejkode,
ab.CVRAdresse_husnummerFra,
ab.CVRAdresse_etagebetegnelse,
ab.CVRAdresse_doerbetegnelse,
ab.CVRAdresse_kommunekode,
ab.CVRAdresse_kommunenavn,
ab.CVRAdresse_postdistrikt,
ab.CVRAdresse_vejnavn,
ab.CVRAdresse_husnummerTil,
ab.CVRAdresse_postnummer,
ab.CVRAdresse_supplerendeBynavn,
ab.CVRAdresse_adresseFritekst,
ab.CVRAdresse_landekode,
ab.coNavn,
HB.Vaerdi,
HB.VaerdiTekst,
BB1.Vaerdi,
BB1.VaerdiTekst,
BB2.Vaerdi,
BB2.VaerdiTekst,
BB3.Vaerdi,
BB3.VaerdiTekst,
be.beskaeftigelsestalstype,
be.antal,
be.datoFra,
be.datoTil,
be.intervalFra,
be.intervalTil,
be.registreringsdato,
P.Pnummer,
P.Vaerdi,
FAD.CVREnhedid,
FAD.Vaerdi as FADNavn,
FAD.enhedsType as FADenhedsType

FROM 
CVREnhed as CVRE 
inner join Virksomhed 				as v 	on v.id = CVRE.id
Left join emailadresse				as e 	on v.id = e.cvrenhedsid
Left join navn						as n 	on v.id = n.cvrenhedsid
Left join telefonnummer				as t 	on v.id = t.cvrenhedsid
Left join adressering 				as ap 	on v.id = ap.cvrenhedsid and ap.adresseringanvendelse = 'postadresse'  /*anvendes ved postadresse*/
Left join adressering 				as ab 	on v.id = ab.cvrenhedsid and ab.adresseringanvendelse = 'beliggenhedsadresse'  /*anvendes ved beliggenhedsadresse*/							/*anvendes ved beliggenhedsadresse*/
Left join virksomhedsform 			as f 	on v.id = f.cvrenhedsid								/*anvendes ved virksomhedsform*/
Left join branche 					as Hb 	on v.id = Hb.cvrenhedsid  and sekvens = 0			/*anvendes ved Hovbranche*/
Left join branche 					as bb1 	on v.id = bb1.cvrenhedsid and sekvens = 1			/*anvendes ved Bi branche 1*/
Left join branche 					as bb2 	on v.id = bb2.cvrenhedsid and sekvens = 2			/*anvendes ved Bi branche 2*/
Left join branche 					as bb3 	on v.id = bb3.cvrenhedsid and sekvens = 3			/*anvendes ved Bi branche 3*/
Left join Kreditoplysninger 		as k 	on v.id = k.cvrenhedsid								/*anvendes ved Kreditoplysninger*/
Left join reklamebeskyttelse 		as R 	on v.id = R.cvrenhedsid								/*anvendes ved reklamebeskyttet*/
Left join ansvarligDataleverandoer 	as Ad 	on v.id = AD.cvrenhedsid							/*anvendes ved ansvarligDataleverandoer*/
Left join beskaeftigelse 			as be 	on v.id = Be.cvrenhedsid
Left join 	(select pNummer, Vaerdi from Produktionsenhed Pe 
				left join navn np on Pe.id = np.CVREnhedsid
				where
				(pRegistreringstid is not null and np.registreringfra = (select max(registreringfra) from navn as npr where pe.id = npr.cvrenhedsid and registreringfra <= pRegistreringstid)) and
				np.virkningfra = (select max(virkningfra) from navn as npv where pe.id = npv.cvrenhedsid and virkningfra >= pVirkningstid)
				
			)						as p 	on v.CVRNummer = Pe.tilknyttetVirksomhedsCVRNummer
Left join 	(select id,
					fadi.cvrenhedsid
					enhedsType,
					deltagendeEnhedsId,
					CVREnhed.forretningsnoegleType,		/*  Angiver fortolkning af forretningsnoegle "PNummer, CVRNummer eller CVREnhedsid" */
					CVREnhed.forretningsnoegle, 			/* "Noeglensvaerdi" */
					CVREnhed.enhedsType,					/* "Virksomhed, Produktionsenhed, CVRPerson eller AndreDeltagere" */					
					navn.Vaerdi 
			from  FuldtAnsvarligDeltagerRelation FADi
			left join CVREnhed on CVREnhedsId = id
			left join navn on navn.CVREnhedsId = FADi.CVREnhedsId
			where
				(pRegistreringstid is not null and 
				FADi.registreringfra = 	(select max(registreringfra) 	from FuldtAnsvarligDeltagerRelation as FADr where CVREnhed.id = FADr.cvrenhedsid and registreringfra <= pRegistreringstid) and
				navn.registreringfra = 	(select max(registreringfra) 	from navn 							as navn where CVREnhed.id = navn.cvrenhedsid and registreringfra <= pRegistreringstid)) and
				FADi.virkningfra = 		(select max(virkningfra) 		from FuldtAnsvarligDeltagerRelation as FADv where CVREnhed.id = FADv.cvrenhedsid and virkningfra >= pVirkningstid) and
				navn.virkningfra = 		(select max(virkningfra) 		from navn 							as navn where CVREnhed.id = navn.cvrenhedsid and virkningfra >= pVirkningstid)
			)as FAD	on V.id = FAD.id									/*Gives en liste over FAD, deres navner og enhedsType*/


where 
v.CVRNummer = pCVRNummer and      /*Filter på CVRNummer*/



/*Håndtering af RegistreringsTid*/
and (pRegistreringstid is not null and 
v.registreringfra = 	(select max(registreringfra) from virksomhed 				as vr 	where v.id = vr.id  			and registreringfra <= pRegistreringstid) and
e.registreringfra = 	(select max(registreringfra) from emailadresse 				as er 	where v.id = er.cvrenhedsid 	and registreringfra <= pRegistreringstid) and
n.registreringfra = 	(select max(registreringfra) from navn 						as nr	where v.id = nr.cvrenhedsid 	and registreringfra <= pRegistreringstid) and
t.registreringfra = 	(select max(registreringfra) from telefonnummer 			as tr	where v.id = tr.cvrenhedsid		and registreringfra <= pRegistreringstid) and 
ap.registreringfra = 	(select max(registreringfra) from adressering 				as apr	where v.id = apr.cvrenhedsid	and registreringfra <= pRegistreringstid) and --anvendes ved postadresse
ab.registreringfra = 	(select max(registreringfra) from adressering 				as abr	where v.id = abr.cvrenhedsid	and registreringfra <= pRegistreringstid) and --anvendes ved beliggenhedsadresse
f.registreringfra = 	(select max(registreringfra) from virksomhedsform 			as fr	where v.id = fr.cvrenhedsid		and registreringfra <= pRegistreringstid) and -- anvendes ved virksomhedsform
Hb.registreringfra  = 	(select max(registreringfra) from branche 					as br0	where v.id = br0.cvrenhedsid	and registreringfra <= pRegistreringstid and br0.Sekvens = 0 ) and -- anvendes ved Hovedbranchebranche
bb1.registreringfra = 	(select max(registreringfra) from branche 					as br1	where v.id = br1.cvrenhedsid	and registreringfra <= pRegistreringstid and br1.Sekvens = 1 ) and -- anvendes ved Bi branche1 
bb2.registreringfra = 	(select max(registreringfra) from branche 					as br2	where v.id = br2.cvrenhedsid	and registreringfra <= pRegistreringstid and br2.Sekvens = 2 ) and -- anvendes ved Bi branche2 
bb3.registreringfra = 	(select max(registreringfra) from branche 					as br3	where v.id = br3.cvrenhedsid	and registreringfra <= pRegistreringstid and br3.Sekvens = 3 ) and -- anvendes ved Bi branche3 
k.registreringfra = 	(select max(registreringfra) from Kreditoplysninger 		as kr	where v.id = kr.cvrenhedsid		and registreringfra <= pRegistreringstid) and -- anvendes ved Kreditoplysninger 
R.registreringfra = 	(select max(registreringfra) from reklamebeskyttelse  		as Rr 	where v.id = Rr.cvrenhedsid		and registreringfra <= pRegistreringstid) and -- anvendes ved reklamebeskyttet 
AD.registreringfra = 	(select max(registreringfra) from ansvarligDataleverandoer 	as ADr	where v.id = ADr.cvrenhedsid	and registreringfra <= pRegistreringstid)) and -- anvendes ved ansvarligDataleverandoer 

/*Håndtering af VirkningsTid*/
v.virkningfra = 	(select max(virkningfra) from virksomhed				as vv	where v.id = vv.id 				and virkningfra <= pVirkningstid ) and
e.virkningfra =		(select max(virkningfra) from emailadresse				as ev	where v.id = ev.cvrenhedsid 	and virkningfra <= pVirkningstid ) and
n.virkningfra =		(select max(virkningfra) from navn						as nv	where v.id = nv.cvrenhedsid 	and virkningfra <= pVirkningstid ) and
t.virkningfra =		(select max(virkningfra) from telefonnummer				as tv	where v.id = tv.cvrenhedsid 	and virkningfra <= pVirkningstid ) and
ap.virkningfra =	(select max(virkningfra) from adressering				as apv	where v.id = apv.cvrenhedsid	and virkningfra <= pVirkningstid ) and 		/*anvendes ved postadresse*/
ab.virkningfra =	(select max(virkningfra) from adressering				as abv	where v.id = abv.cvrenhedsid	and virkningfra <= pVirkningstid ) and		/*anvendes ved beliggenhedsadresse*/
f.virkningfra  =	(select max(virkningfra) from virksomhedsform			as fv	where v.id = fv.cvrenhedsid 	and virkningfra <= pVirkningstid ) and 		/*anvendes ved virksomhedsform*/
HB.virkningfra =	(select max(virkningfra) from branche 					as bv0	where v.id = bv0.cvrenhedsid	and bv0.virkningfra <= pVirkningstid and bv0.Sekvens = 0 ) and 		/*anvendes ved Hovedbranchebranche */
BB1.virkningfra =	(select max(virkningfra) from branche 					as bv1	where v.id = bv1.cvrenhedsid	and bv1.virkningfra <= pVirkningstid and bv1.Sekvens = 1 ) and 		/*anvendes ved bibranchebranche 1*/
BB2.virkningfra =	(select max(virkningfra) from branche 					as bv2	where v.id = bv2.cvrenhedsid	and bv2.virkningfra <= pVirkningstid and bv2.Sekvens = 2 ) and 		/*anvendes ved bibranchebranche 2*/
BB3.virkningfra =	(select max(virkningfra) from branche 					as bv3	where v.id = bv3.cvrenhedsid	and bv3.virkningfra <= pVirkningstid and bv3.Sekvens = 3 ) and 		/*anvendes ved bibranchebranche 3*/
k.virkningfra =		(select max(virkningfra) from Kreditoplysninger 		as kv	where v.id = kv.cvrenhedsid		and virkningfra <= pVirkningstid ) and		/*anvendes ved Kreditoplysninger*/
R.virkningfra =		(select max(virkningfra) from reklamebeskyttelse 		as Rv	where v.id = Rv.cvrenhedsid		and virkningfra <= pVirkningstid ) and 		/*anvendes ved reklamebeskyttet.*/
AD.virkningfra =	(select max(virkningfra) from ansvarligDataleverandoer 	as ADv	where v.id = ADv.cvrenhedsid	and virkningfra <= pVirkningstid );		/*anvendes ved reklamebeskyttet.*/

