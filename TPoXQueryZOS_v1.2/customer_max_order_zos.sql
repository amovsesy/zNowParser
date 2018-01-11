------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------


------------------------------------------------------------------------
-- Return the most expensive order of the customer with the specified id.
------------------------------------------------------------------------

SELECT VARCHAR(Decimal(CAST(MAX(PRICE) AS INTEGER), 15,2)) as MAXPRICE
FROM 
( 
    SELECT  
        CAST(CAST
        (XMLSERIALIZE 
            (XMLQUERY('declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
                fn:string($odoc/FIXML/Order/OrdQty/@Cash)
                '
                PASSING odoc AS "odoc") 
            AS CLOB(20)
            )
        AS VARCHAR(20)
        )
        AS DOUBLE)
    FROM custacc, order
    WHERE XMLEXISTS 
            (
            '
            declare namespace c="http://tpox-benchmark.com/custacc";
            $cadoc/c:Customer[@id=1002]' 
            PASSING cadoc AS "cadoc"
            ) 
        AND XMLEXISTS 
            (
            '
            declare default element namespace "http://www.fixprotocol.org/FIXML-4-4";
            declare namespace c="http://tpox-benchmark.com/custacc";
            $odoc/FIXML/Order[@Acct=$cadoc/c:Customer/c:Accounts/c:Account/@id/fn:string(.)]
            ' 
            PASSING cadoc AS "cadoc", odoc AS "odoc")
) T(price)
