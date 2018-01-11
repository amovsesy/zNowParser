------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------


------------------------------------------------------------------------
-- Retrieve the names of the customers in the specified country
-- who have orders higher in value than the specified one.
------------------------------------------------------------------------

SELECT XMLQUERY(
'
declare namespace c="http://tpox-benchmark.com/custacc";
$cadoc/c:Customer/c:ShortNames/c:ShortName
'
PASSING cadoc AS "cadoc")
FROM custacc, order
WHERE 
XMLEXISTS
(
'
declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
declare namespace c="http://tpox-benchmark.com/custacc";
$cadoc/c:Customer[c:CountryOfResidence="Taiwan" and c:Accounts/c:Account/@id=$odoc/FIXML/Order/@Acct/fn:string(.)]
'
PASSING cadoc AS "cadoc", odoc AS "odoc"
)
AND XMLEXISTS
(
'
declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
$odoc/FIXML/Order/OrdQty[@Cash>3000]
'
PASSING cadoc AS "cadoc", odoc AS "odoc"
)
