------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------


------------------------------------------------------------------------
-- Get the phone numbers of customers in a specific zip code who have
-- sold any security. Sort by customer last name.
------------------------------------------------------------------------

SELECT 
    CAST(XMLSERIALIZE(
        XMLQUERY( 
            '
            declare namespace c="http://tpox-benchmark.com/custacc";
            fn:concat(
                $cadoc/c:Customer/c:Name/c:LastName/text(),   
                "-",
                $cadoc/c:Customer/c:Addresses/c:Address[@primary="Yes"]/c:Phones/c:Phone[@primary="Yes"]
            )
           ' 
            PASSING cadoc AS "cadoc" 
        ) AS CLOB(500) )
        AS VARCHAR(500) ) 
    AS Customers
FROM custacc, order
WHERE XMLEXISTS 
(
'
declare namespace c="http://tpox-benchmark.com/custacc";
$cadoc/c:Customer[c:Addresses/c:Address/c:PostalCode=26652]' 
PASSING cadoc AS "cadoc"
) 
AND XMLEXISTS 
(
'
declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
declare namespace c="http://tpox-benchmark.com/custacc";
$odoc/FIXML/Order[@Acct=$cadoc/c:Customer/c:Accounts/c:Account/@id/fn:string(.) and @Side="2"]
' 
PASSING cadoc AS "cadoc", odoc AS "odoc"
)
ORDER BY Customers
