SELECT 
CVRE.id,						/*"description": "EAID_A09EF54A_A9A3_413b_94C2_805EFA701A52"*/
CVRE.status,
CVRE.forretningsnoegleType		/*  Angiver fortolkning af forretningsnoegle "PNummer, CVRNummer eller CVREnhedsid" */
CVRE.forretningsnoegle 			/* "Noeglensvaerdi" */
CVRE.enhedsType					/* "Virksomhed, Produktionsenhed, CVRPerson eller AndreDeltagere" */
n.vaerdi,						/*description": "EAID_AE8C2560_67DF_41e3_98D3_AD8500846E9B"*/
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
FROM 
CVREnhed as CVRE 
inner join AndreDeltagere 	as a 	on CVRE.id = A.id
left join navn 				as n 	on A.id = n.cvrenhedsid
left join adressering 		as ap 	on A.id = ap.cvrenhedsid and ap.adresseringanvendelse = 'postadresse' /*anvendes ved postadresse*/
left join adressering 		as ab 	on p.id = ab.cvrenhedsid and ab.adresseringanvendelse = 'beliggenhedsadresse' /*anvendes ved beliggenhedsadresse*/
where
CVRE.id = pid and			/*filter på CVREnhedsid*/

/*Håndtering af RegistreringsTid*/
and (pRegistreringstid is not null and 
A.registreringfra 	= (select max(registreringfra) from AndreDeltagere 		as ar  where A.id = ar.id 				and registreringfra <= pRegistreringstid) and
n.registreringfra 	= (select max(registreringfra) from navn 				as nr  where A.id = nr.cvrenhedsid 		and registreringfra <= pRegistreringstid) and
ap.registreringfra	= (select max(registreringfra) from adressering 		as apr where A.id = apr.cvrenhedsid 	and registreringfra <= pRegistreringstid) and 						/* anvendes ved postadresse*/
ab.registreringfra 	= (select max(registreringfra) from adressering 		as abr where A.id = abr.cvrenhedsid 	and registreringfra <= pRegistreringstid) and 						/* anvendes ved beliggenhedsadresse*/ 
)

/*Håndtering af VirkningsTid*/
A.virkningfra 	= (select max(virkningfra) from AndreDeltagere 		as pv  where A.id = pv.id 			and pv.virkningfra 	<= pVirkningstid ) and
n.virkningfra 	= (select max(virkningfra) from navn 				as nv  where A.id = nv.cvrenhedsid 	and nv.virkningfra 	<= pVirkningstid ) and
ap.virkningfra	= (select max(virkningfra) from adressering 		as apv where A.id = apv.cvrenhedsid and apv.virkningfra <= pVirkningstid ) and									/* anvendes ved postadresse*/
ab.virkningfra	= (select max(virkningfra) from adressering 		as abv where A.id = abv.cvrenhedsid and abv.virkningfra <= pVirkningstid );										/* anvendes ved beliggenhedsadresse*/

