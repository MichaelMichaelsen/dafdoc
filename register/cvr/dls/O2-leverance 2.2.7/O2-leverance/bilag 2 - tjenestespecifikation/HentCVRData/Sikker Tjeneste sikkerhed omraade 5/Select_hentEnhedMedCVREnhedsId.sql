SELECT 
CVRE.id,						/*"description": "EAID_A09EF54A_A9A3_413b_94C2_805EFA701A52"*/
CVRE.status,
CVRE.forretningsnoegleType,		/*  Angiver fortolkning af forretningsnoegle "PNummer, CVRNummer eller CVREnhedsid" */
CVRE.forretningsnoegle, 			/* "Noeglensvaerdi" */
CVRE.enhedsType					/* "Virksomhed, Produktionsenhed, CVRPerson eller AndreDeltagere" */
FROM 
CVREnhed as CVRE
left join Virksomhed	 	as v 	on CVRE.forretningsnoegle = v.CVRNummer 
left join Produktionsenhed 	as pe 	on CVRE.forretningsnoegle = pe.pNummer 
left join CVRPerson 		as p 	on CVRE.forretningsnoegle = p.id
left join AndreDeltagere 	as a 	on CVRE.forretningsnoegle = a.id 

where 
CVRE.id = pId and 				/* filter på CVREnhedsid */
(pRegistreringstid is not null and 
v.registreringfra 	= (select max(registreringfra) from Virksomhed 	as vr  where CVRE.forretningsnoegle = v.CVRNummer 	and v.registreringfra <= pRegistreringstid ) and
pe.registreringfra 	= (select max(registreringfra) from Produktionsenhed 	as per where CVRE.forretningsnoegle = pe.pNummer 	and v.registreringfra <= pRegistreringstid ) and
p.registreringfra 	= (select max(registreringfra) from CVRPerson 	as pr  where CVRE.forretningsnoegle = p.id 	and p.registreringfra <= pRegistreringstid) and
a.registreringfra 	= (select max(registreringfra) from AndreDeltagere 	as ar  where CVRE.forretningsnoegle = a.id 	and a.registreringfra <= pRegistreringstid )) and
v.virkningfra 		= (select max(virkningfra) from Virksomhed		as vv  where CVRE.forretningsnoegle = v.CVRNummer 	and v.virkningfra 	<= pVirkningstid ) and
pe.virkningfra 		= (select max(virkningfra) from Produktionsenhed		as pev where CVRE.forretningsnoegle = pe.pNummer 	and v.virkningfra 	<= pVirkningstid ) and
p.virkningfra 		= (select max(virkningfra) from CVRPerson		as pv  where CVRE.forretningsnoegle = p.id 	and p.virkningfra 	<= pVirkningstid ) and
a.virkningfra 		= (select max(virkningfra) from AndreDeltagere		as av  where CVRE.forretningsnoegle = a.id 	and a.virkningfra 	<= pVirkningstid );

