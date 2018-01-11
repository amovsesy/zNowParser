------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------


------------------------------------------------------------------------
-- Retrieve an order with the specific ID.
------------------------------------------------------------------------
SELECT XMLQUERY
(
'declare namespace o="http://www.fixprotocol.org/FIXML-4-4";
$odoc/o:FIXML/o:Order
'
PASSING odoc AS "odoc"
)
FROM order
WHERE XMLEXISTS
(
'declare namespace o="http://www.fixprotocol.org/FIXML-4-4";
$odoc/o:FIXML/o:Order[@ID="103282"]
'
PASSING odoc AS "odoc"
)

