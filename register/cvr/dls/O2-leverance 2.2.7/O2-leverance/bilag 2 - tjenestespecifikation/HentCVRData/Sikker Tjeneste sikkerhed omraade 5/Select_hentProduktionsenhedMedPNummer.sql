SELECT 
CVRE.id,						/*"description": "EAID_A09EF54A_A9A3_413b_94C2_805EFA701A52"*/
p.status,
p.PNummer,						/*"description": "EAID_564C37C6_7647_4f64_9116_5B273C30D955"*/
P.tilknyttetVirksomhedsCVRNummer,
n.vaerdi,						/*description": "EAID_AE8C2560_67DF_41e3_98D3_AD8500846E9B"*/
P.ProduktionsenhedStartdato,
P.virkningFra,					/*"description": "EAID_DF8A413C_A35D_4a7d_B61C_0B836F8E6C22"*/
P.virkningTil 					/*"description": "EAID_7B6826FD_9124_47aa_96D5_CFB39C172311"*/
R.vaerdi,
AD.vaerdi,
e.vaerdi,
t.vaerdi,
ap.Adresse,						/*DAR UUID*/
ap.AdresseAndvendelse,
ap.CVRAdresse_vejkode,
ap.CVRAdresse_husnummerFra,
ap.CVRAdresse_etagebetegnelse,
ap.CVRAdresse_doerbetegnelse,
ap.CVRAdresse_kommunekode,
ap.CVRAdresse_kommunenavn,
ap.CVRAdresse_postdistrikt,
ap.CVRAdresse_vejnavn,
ap.CVRAdresse_husnummerTil
ap.CVRAdresse_postnummer,
ap.CVRAdresse_supplerendeBynavn,
ap.CVRAdresse_adresseFritekst,
ap.CVRAdresse_landekode,
ap.coNavn,
ab.Adresse,					/*DAR UUID*/
ap.AdresseAndvendelse,
ab.CVRAdresse_vejkode,
ab.CVRAdresse_husnummerFra,
ab.CVRAdresse_etagebetegnelse,
ab.CVRAdresse_doerbetegnelse,
ab.CVRAdresse_kommunekode,
ab.CVRAdresse_kommunenavn,
ab.CVRAdresse_postdistrikt,
ab.CVRAdresse_vejnavn,
ab.CVRAdresse_husnummerTil
ab.CVRAdresse_postnummer,
ab.CVRAdresse_supplerendeBynavn,
ab.CVRAdresse_adresseFritekst,
ab.CVRAdresse_landekode,
ab.coNavn,
HB.Vaerdi,
HB.VaerdiTeskst,
BB1.Vaerdi,
BB1.VaerdiTeskst,
BB2.Vaerdi,
BB2.VaerdiTeskst,
BB3.Vaerdi,
BB3.VaerdiTeskst,
be.beskaeftigelsestalstype,
be.datoFra,
be.datoTil,
be.intervalFra,
be.intervalTil,
be.registreringsdato
FROM 
CVREnhed as CVRE 
inner join Produktionsenhed as p 	on CVRE.id = P.id
left join emailadresse 		as e 	on P.id = e.cvrenhedsid 
left join navn 				as n 	on P.id = n.cvrenhedsid
left join telefonnummer 	as t 	on P.id = t.cvrenhedsid
left join adressering 		as ap 	on P.id = ap.cvrenhedsid and ap.adresseringanvendelse = 'postadresse' 			/*anvendes ved postadresse*/
left join adressering 		as ab 	on p.id = ab.cvrenhedsid and ab.adresseringanvendelse = 'beliggenhedsadresse' 	/*anvendes ved beliggenhedsadresse*/
left join branche 			as Hb 	on P.id = Hb.cvrenhedsid 	and hb.sekvense  = 0 				/* anvendes ved Hovbranche*/
left join branche 			as bb1 	on p.id = bb1.cvrenhedsid  	and bb1.sekvense = 1 				/*anvendes ved Bi branche 1*/
left join branche 			as bb2 	on p.id = bb2.cvrenhedsid 	and bb2.sekvense = 2 				/*anvendes ved Bi branche 2*/
left join branche 			as bb3 	on p.id = bb3.cvrenhedsid 	and bb3.sekvense = 3 				/*anvendes ved Bi branche 3*/
left join reklamebeskyttet 	as R 	on P.id = R.cvrenhedsid  										/*anvendes ved reklamebeskyttet*/
left join beskaeftigelse 	as be 	on P.id = be.cvrenhedsid 	and pInkluderBeskaeftigelse = true
													and be.beskaeftigelsestalstype in 	('AarsbeskaeftigelseAntalAarsvaerkInterval',
																					'AarsbeskaeftigelseAntalAnsatteInterval',
																					'AarsbeskaeftigelseAntalAnsatteInklusivEjereInterval',
																					'KvartalsbeskaeftigelseAntalAarsvaerkInterval',
																					'KvartalsbeskaeftigelseAntalAnsatteInterval',
																					'MaanedsbeskaeftigelseAntalAarsvaerkInterval',
																					'MaanedsbeskaeftigelseAntalAnsatteInterval')

where
P.Pnummer = pPNummer and			/*filter på Pnummer*/
/*Håndtering af RegistreringsTid*/
and (pRegistreringstid is not null and 
P.registreringfra 	= (select max(registreringfra) from Produktionsenhed 	as pr  where P.id = pr.id 				and registreringfra <= pRegistreringstid) and
e.registreringfra 	= (select max(registreringfra) from emailadresse 		as er  where P.id = er.cvrenhedsid 		and registreringfra <= pRegistreringstid) and
n.registreringfra 	= (select max(registreringfra) from navn 				as nr  where P.id = nr.cvrenhedsid 		and registreringfra <= pRegistreringstid) and
t.registreringfra 	= (select max(registreringfra) from telefonnummer 		as tr  where P.id = tr.cvrenhedsid 		and registreringfra <= pRegistreringstid) and 
ap.registreringfra	= (select max(registreringfra) from adressering 		as apr where P.id = apr.cvrenhedsid 	and registreringfra <= pRegistreringstid) and 						/* anvendes ved postadresse*/
ab.registreringfra 	= (select max(registreringfra) from adressering 		as abr where P.id = abr.cvrenhedsid 	and registreringfra <= pRegistreringstid) and 						/* anvendes ved beliggenhedsadresse*/
Hb.registreringfra  = (select max(registreringfra) from branche 			as br0 where P.id = br0.cvrenhedsid		and registreringfra <= pRegistreringstid and br0.Sekvens = 0 ) and 	/* anvendes ved Hovedbranchebranche*/
bb1.registreringfra = (select max(registreringfra) from branche 			as br1 where P.id = br1.cvrenhedsid		and registreringfra <= pRegistreringstid and br1.Sekvens = 1 ) and	/* anvendes ved Bi branche1 */
bb2.registreringfra = (select max(registreringfra) from branche 			as br2 where P.id = br2.cvrenhedsid		and registreringfra <= pRegistreringstid and br2.Sekvens = 2 ) and 	/* anvendes ved Bi branche2*/ 
bb3.registreringfra = (select max(registreringfra) from branche 			as br3 where P.id = br3.cvrenhedsid		and registreringfra <= pRegistreringstid and br3.Sekvens = 3 ) and 	/* anvendes ved Bi branche3 */
R.registreringfra 	= (select max(registreringfra) from reklamebeskyttet  	as Rr  where P.id = Rr.cvrenhedsid		and registreringfra <= pRegistreringstid)) and 						/* anvendes ved reklamebeskyttet*/ 

/*Håndtering af VirkningsTid*/
P.virkningfra 	= (select max(virkningfra) from Produktionsenhed 	as pv  where P.id = pv.id 			and pv.virkningfra 	<= pVirkningstid ) and
e.virkningfra 	= (select max(virkningfra) from emailadresse 		as ev  where P.id = ev.cvrenhedsid 	and ev.virkningfra 	<= pVirkningstid ) and
n.virkningfra 	= (select max(virkningfra) from navn 				as nv  where P.id = nv.cvrenhedsid 	and nv.virkningfra 	<= pVirkningstid ) and
t.virkningfra 	= (select max(virkningfra) from telefonnummer 		as tv  where P.id = tv.cvrenhedsid 	and tv.virkningfra 	<= pVirkningstid ) and
ap.virkningfra	= (select max(virkningfra) from adressering 		as apv where P.id = apv.cvrenhedsid and apv.virkningfra <= pVirkningstid ) and									/* anvendes ved postadresse*/
ab.virkningfra	= (select max(virkningfra) from adressering 		as abv where P.id = abv.cvrenhedsid and abv.virkningfra <= pVirkningstid ) and									/* anvendes ved beliggenhedsadresse*/
HB.virkningfra	= (select max(virkningfra) from branche 			as bv0 where P.id = bv0.cvrenhedsid and bv0.virkningfra <= pVirkningstid and bv0.Sekvens = 0 ) and 				/* anvendes ved Hovedbranchebranche*/ 
BB1.virkningfra = (select max(virkningfra) from branche 			as bv1 where P.id = bv1.cvrenhedsid and bv1.virkningfra <= pVirkningstid and bv1.Sekvens = 1 ) and 				/* anvendes ved bibranchebranche 1*/
BB2.virkningfra = (select max(virkningfra) from branche 			as bv2 where P.id = bv2.cvrenhedsid and bv2.virkningfra <= pVirkningstid and bv2.Sekvens = 2 ) and 				/* anvendes ved bibranchebranche 2*/
BB3.virkningfra = (select max(virkningfra) from branche 			as bv3 where P.id = bv3.cvrenhedsid and bv3.virkningfra <= pVirkningstid and bv3.Sekvens = 3 ) and 				/* anvendes ved bibranchebranche 3*/
R.virkningfra 	= (select max(virkningfra) from reklamebeskyttet 	as Rv  where P.id = Rv.cvrenhedsid  and Rv.virkningfra 	<= pVirkningstid );									/* anvendes ved reklamebeskyttet.*/
