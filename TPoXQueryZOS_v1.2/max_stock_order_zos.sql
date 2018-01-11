------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Return the max order value for the stocks bought by the customers
-- living in the specified state (for the securities in the
-- specified industry).
------------------------------------------------------------------------

select VARCHAR(max(T.cash))
from (
    SELECT CAST
            (CAST
                (XMLSERIALIZE
                        (XMLQUERY( 'declare default element namespace "http://www.fixprotocol.org/FIXML-4-4"; 
		                            fn:string($odoc/FIXML/Order/OrdQty/@Cash)' 
                                    PASSING odoc AS "odoc") 
                        as CLOB(20) ) 
                AS VARCHAR(20)) 
            AS float) 
            As cash 
    FROM custacc, order, security
    WHERE XMLEXISTS
    ('
    declare namespace s="http://tpox-benchmark.com/security"; 
    $sdoc/s:Security[s:SecurityInformation/s:StockInformation/s:Industry ="Software&amp;Programming"]
    ' 
    PASSING sdoc as "sdoc") 
    and
    XMLEXISTS
    ('
    declare default element namespace "http://www.fixprotocol.org/FIXML-4-4"; 
    declare namespace s="http://tpox-benchmark.com/security"; 
    $odoc/FIXML/Order[Instrmt/@Sym=$sdoc/s:Security/s:Symbol/fn:string(.)]
    ' 
    PASSING odoc as "odoc", sdoc as "sdoc") 
    and 
    XMLEXISTS
    ('
    declare default element namespace "http://www.fixprotocol.org/FIXML-4-4"; 
    declare namespace c="http://tpox-benchmark.com/custacc"; 
    $cadoc/c:Customer[c:Addresses/c:Address/c:State="West Virginia"]/c:Accounts/c:Account
    [@id=$odoc/FIXML/Order/@Acct/fn:string(.)] 
    ' 
    PASSING cadoc AS "cadoc", odoc as "odoc") 
) as T
