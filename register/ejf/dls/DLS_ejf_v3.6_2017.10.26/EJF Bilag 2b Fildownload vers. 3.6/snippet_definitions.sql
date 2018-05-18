--
-- Determine wether a person is under address protection. If any results are
-- returned from the query, the person is under address protection. This is used
-- as a subquery. Note that any point-in-time or period input parameters are
-- intentionally ignored, as the check should always be applied to the current
-- situation.
--
-- [table_alias] - The name of the table in the parent query, where the CPR
--                 number is set in a column.
-- [cpr_column]  - The name of the column of the the table where the CPR is set.
--
[def:snippet_cpr_beskyttet(table_alias, cpr_column)]
SELECT * FROM CPR.Beskyttelse beskyttelse
JOIN CPR.Person beskyttet_person ON beskyttet_person.id = beskyttelse.personid
    AND (beskyttet_person.registreringfra IS NULL OR beskyttet_person.registreringfra <= NOW()) AND (beskyttet_person.registreringtil IS NULL OR beskyttet_person.registreringtil > NOW())
    AND beskyttet_person.virkningfra <= NOW() AND (beskyttet_person.virkningtil IS NULL OR beskyttet_person.virkningtil > NOW())
JOIN CPR.Personnummer beskyttet_person_personnumre on beskyttet_person_personnumre.personid = person.id
    AND beskyttet_person_personnumre.personnummer = [table_alias].[cpr_column]
    AND beskyttet_person_personnumre.virkningfra <= NOW() AND (beskyttet_person_personnumre.virkningtil IS NULL OR beskyttet_person_personnumre.virkningtil > NOW())
WHERE beskyttelse.beskyttelsestype = 'navne_og_adresse'
AND beskyttelse.virkningfra <= NOW() AND (beskyttelse.virkningtil IS NULL OR beskyttelse.virkningtil > NOW())

--
-- Applies bitemporal point-in-time constraints.
--
-- [table_alias] - The name of the table the constraints are applied to.
--
[def:snippet_bitemp_full(table_alias)]
AND [table_alias].registreringFra <= @Registreringstid AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > @Registreringstid)
AND [table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)

--
-- Applies temporal point-in-time constraints, but sets Registreringstid to NOW() deliberately.
--
-- [table_alias] - The name of the table the constraints are applied to.
--
[def:snippet_bitemp_virkning(table_alias)]
AND [table_alias].registreringFra <= NOW() AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > NOW())
AND [table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)

--
-- Applies bite,poral point-in-time constraints the current time, ignoring the parameters @Registreringstid and @Virkningstid
--
-- [table_alias] - The name of the table the constraints are applied to.
--
[def:snippet_bitemp_full_now(table_alias)]
AND [table_alias].registreringFra <= NOW() AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > NOW())
AND [table_alias].virkningFra <= NOW() AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > NOW())

--
-- Applies bitemporal point-in-time constraints if a certain column contains a
-- non-null value. This is used when af table is left joined and the columns may
-- be empty if no relation exists. The check column is a mandatory non-null
-- column, which means that its absence always indicates that there's no
-- relation.
--
-- [table_alias]  - The name of the table the constraints are applied to.
-- [check_column] - The name of a mandatory column used to check existence of 
--                  the relation.
--
[def:snippet_bitemp_full_optional(table_alias, check_column)]
AND ([table_alias].[check_column] IS NULL -- Ignore the following constraints if the check column is NULL.
    OR ([table_alias].registreringFra <= @Registreringstid AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > @Registreringstid)
    AND [table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)))


--
-- Applies bitemporal point-in-time constraints if a certain column contains a
-- non-null value. This is used when af table is left joined and the columns may
-- be empty if no relation exists. The check column is a mandatory non-null
-- column, which means that its absence always indicates that there's no
-- relation.
-- This version specifically ignores Registreringstid
--
-- [table_alias]  - The name of the table the constraints are applied to.
-- [check_column] - The name of a mandatory column used to check existence of 
--                  the relation.
--
[def:snippet_bitemp_virkning_optional(table_alias, check_column)]
AND ([table_alias].[check_column] IS NULL -- Ignore the following constraints if the check column is NULL.
    OR ([table_alias].registreringFra <= NOW() AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > NOW())
    AND [table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)))

--
-- Applies bitemporal point-in-time constraints in the same way as the snippet
-- snippet_bitemp_full_optional. This is however tailored specifically for CPR
-- because registreringFra can be null.
--
-- [table_alias]  - The name of the table the constraints are applied to.
-- [check_column] - The name of a mandatory column used to check existence of 
--                  the relation.
--
[def:snippet_bitemp_virkning_cpr_optional(table_alias, check_column)]
AND ([table_alias].[check_column] IS NULL -- Ignore the following constraints if the check column is NULL.
    OR (([table_alias].registreringFra IS NULL OR [table_alias].registreringFra <= NOW()) AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > NOW())
    AND [table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)))

--
-- Applies bitemporal point-in-time constraints in the same way as the snippet
-- snippet_bitemp_full_optional. This is however tailored specifically for CPR
-- because registreringFra can be null.
--
-- [table_alias]  - The name of the table the constraints are applied to.
-- [check_column] - The name of a mandatory column used to check existence of 
--                  the relation.
--
[def:snippet_bitemp_cpr_optional(table_alias, check_column)]
AND ([table_alias].[check_column] IS NULL -- Ignore the following constraints if the check column is NULL.
    OR (([table_alias].registreringFra IS NULL OR [table_alias].registreringFra <= @Registreringstid) AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > @Registreringstid)
    AND [table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)))

--
-- Applies bitemporal point-in-time constraints in the same way as the snippet
-- snippet_bitemp_full_optional. This is however tailored specifically for CPR
-- because registreringFra can be null. 
-- Also, in this version, Registreringstid input is replaced with NOW()
--
-- [table_alias]  - The name of the table the constraints are applied to.
-- [check_column] - The name of a mandatory column used to check existence of 
--                  the relation.
--
[def:snippet_bitemp_virkning_cpr_optional(table_alias, check_column)]
AND ([table_alias].[check_column] IS NULL -- Ignore the following constraints if the check column is NULL.
    OR (([table_alias].registreringFra IS NULL OR [table_alias].registreringFra <= NOW()) AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > NOW())
    AND [table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)))


--
-- Applies bitemporal point-in-time constraints if a certain column contains a
-- non-null value. This only applies constraints for virkning and is used when
-- joining table from CPR, which do not include registrering. This is used when 
-- a table is left joined and the columns may be empty if no relation exists. 
-- The check column is a mandotory non-null column, which means that its absence
-- always indicates that there's no relation.
--
-- [table_alias]  - The name of the table the constraints are applied to.
-- [check_column] - The name of a mandatory column used to check existence of
--                  the relation.
--
[def:snippet_bitemp_virk_optional(table_alias, check_column)]
AND ([table_alias].[check_column] IS NULL -- Ignore the following constraints if the check column is NULL.
    OR ([table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)))

--
-- Applies bitemporal constraints for point-in-time as well as period queries. 
-- If a either period bound (to/from) is set, the point-in-time contraints are 
-- ignored. If neither of the period bounds are set, the period constraints are
-- ignored.
-- This works independently for virkning and registrering, such that a point-in-
-- time registrering (@Registreringstid) can be used with a period for virkning
-- (@VirkningstidFra and @VirkningstidTil) and vice versa.
-- Periods must be valid. We define valid as: They can't be emtpy (i.e. from = 
-- to) or in opposite order (i.e. from > to). An invalid period will not yield 
-- any results. Infinite periods are not possible either. If either bound is
-- left out, the query will yeild no results. Note that we assume that
-- comparison with NULL will always be evaluated to FALSE.
--
-- [table_alias] - The name of the table the constraints are applied to.
--
[def:snippet_bitemp_full_with_period(table_alias)]
AND ((@RegistreringstidFra IS NOT NULL OR @RegistreringstidTil IS NOT NULL) -- Ignore the following constraints if either @RegistreringstidFra or @RegistreringstidTil is set
    OR ([table_alias].registreringFra <= @Registreringstid AND ([table_alias].registreringTil IS NULL OR [table_alias].registreringTil > @Registreringstid)))
AND ((@VirkningstidFra IS NOT NULL OR @VirkningstidTil IS NOT NULL) -- Ignore the following constraints if either @VirkningstidFra or @VirkningstidTil is set
    OR ([table_alias].virkningFra <= @Virkningstid AND ([table_alias].virkningTil IS NULL OR [table_alias].virkningTil > @Virkningstid)))
AND ((@RegistreringstidFra IS NULL AND @RegistreringstidTil IS NULL) -- Ignore the following constraints if neither @RegistreringstidFra nor @RegistreringstidTil is set
    OR  (@RegistreringstidFra < @RegistreringstidTil -- Return nothing if specified period is invalid (including if either is NULL)
    AND ([table_alias].registreringTil > @RegistreringstidFra OR [table_alias].registreringTil IS NULL)
    AND  [table_alias].registreringFra < @RegistreringstidTil))
AND ((@VirkningstidFra IS NULL AND @VirkningstidTil IS NULL)  -- Ignore the following constraints if neither @RegistreringstidFra nor @RegistreringstidTil is set
    OR  (@VirkningstidFra < @VirkningstidTil -- Return nothing if specified period is invalid (including if either is NULL)
    AND ([table_alias].virkningTil > @VirkningstidFra OR [table_alias].virkningTil IS NULL)
    AND  [table_alias].virkningFra < @VirkningstidTil))