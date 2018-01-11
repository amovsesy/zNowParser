------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------

------------------------------------------------------------------------
--  Return a security having the specified Symbol.
------------------------------------------------------------------------

SELECT XMLQUERY
(
'declare default element namespace "http://tpox-benchmark.com/security";
$sdoc/Security
'
PASSING sdoc AS "sdoc"
)
FROM security
WHERE XMLEXISTS
('
declare default element namespace "http://tpox-benchmark.com/security";
$sdoc/Security[Symbol= "BCIIPRC"]
'
PASSING sdoc AS "sdoc"
)

