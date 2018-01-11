------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------


------------------------------------------------------------------------
-- Return current open price of a particular order.
------------------------------------------------------------------------

SELECT
    XMLELEMENT( Name "Today_Order_Price",
                XMLQUERY(
                    '
                    declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
                    fn:string($odoc/FIXML/Order/@ID)'
                    PASSING odoc AS "odoc"
                    ),
                XMLQUERY(
                    '
                    declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
                    declare namespace s="http://tpox-benchmark.com/security";

                    $odoc/FIXML/Order/OrdQty/@Qty - $sdoc/s:Security/s:Price/s:PriceToday/s:Open
                    ' 
                    PASSING odoc AS "odoc", sdoc AS "sdoc"  
                    )
    )   
FROM security, order
WHERE XMLEXISTS
(
'
declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
$odoc/FIXML/Order[@ID="109505"]
'
PASSING odoc AS "odoc"
)
AND XMLEXISTS 
(
'
declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
declare namespace s="http://tpox-benchmark.com/security"; 
	  
$sdoc/s:Security[s:Symbol=$odoc/FIXML/Order/Instrmt/@Sym/fn:string(.)]
' 
PASSING sdoc AS "sdoc", odoc AS "odoc"
)
