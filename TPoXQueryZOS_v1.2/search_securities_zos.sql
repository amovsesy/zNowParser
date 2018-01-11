-----------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------



------------------------------------------------------------------------
-- Return a list of securities in a particular sector, with a given P/E and
-- yield range.
-- The query uses - to filter and retrieve both funds and stocks of the sector.
------------------------------------------------------------------------


SELECT 
    XMLELEMENT 
    (
        Name "Security",
        XMLNAMESPACES (DEFAULT 'http://tpox-benchmark.com/security'),
        XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/security";
            $sdoc/Security/Symbol' 
            PASSING  sdoc AS "sdoc"),
        XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/security";
            $sdoc/Security/Name' 
            PASSING  sdoc AS "sdoc"),
        XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/security";
            $sdoc/Security/SecurityType' 
            PASSING  sdoc AS "sdoc"),
        XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/security";
            $sdoc/Security/SecurityInformation//Sector' 
            PASSING  sdoc AS "sdoc"),
        XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/security";
            $sdoc/Security/PE' 
            PASSING  sdoc AS "sdoc"),
        XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/security";
            $sdoc/Security/Yield' 
            PASSING  sdoc AS "sdoc") 
    )
FROM security
WHERE XMLEXISTS
(
'declare default element namespace "http://tpox-benchmark.com/security";
$sdoc/Security[SecurityInformation/*/Sector="Energy" and Yield>4.5]
'
PASSING sdoc AS "sdoc"
)		
AND XMLEXISTS
(
'declare default element namespace "http://tpox-benchmark.com/security";
$sdoc/Security/PE[.>=30 and 35]
'
PASSING sdoc AS "sdoc"
)

