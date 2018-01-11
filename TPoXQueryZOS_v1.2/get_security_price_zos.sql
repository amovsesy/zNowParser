------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Print an open price of a particular security in a user-friendly text
-- message.
------------------------------------------------------------------------

SELECT 
    XMLELEMENT(
        NAME "print", 
        XMLNAMESPACES (DEFAULT 'http://tpox-benchmark.com/security'),
        'The open price of the security', 
        XMLQUERY('declare namespace s="http://tpox-benchmark.com/security";
                    $sdoc/s:Security/s:Name/text()'
                    PASSING sdoc AS "sdoc"
        ),
        ' is ',
        XMLQUERY('declare namespace s="http://tpox-benchmark.com/security";
                    $sdoc/s:Security/s:Price/s:PriceToday/s:Open/text()'
                    PASSING sdoc AS "sdoc"
        ),
        ' dollars'
    )
FROM security
WHERE XMLEXISTS
(
'declare namespace s="http://tpox-benchmark.com/security";
$sdoc/s:Security[s:Symbol= "SFDBX"]
'
PASSING sdoc AS "sdoc"
)

