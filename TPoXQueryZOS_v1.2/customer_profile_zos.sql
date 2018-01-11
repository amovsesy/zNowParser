------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------

------------------------------------------------------------------------
--  Return a customer profile for the specified customer.
------------------------------------------------------------------------


SELECT XMLELEMENT (
    Name "Customer_Profile",
    XMLNAMESPACES (DEFAULT 'http://tpox-benchmark.com/custacc'),
    XMLATTRIBUTES( 
        VARCHAR(XMLSerialize(
                    XMLQUERY ( 'declare default element namespace "http://tpox-benchmark.com/custacc";
                                fn:string($cadoc/Customer/@id)' 
                                PASSING  cadoc AS "cadoc")
                    as CLOB(100))) 
                AS "CUSTOMERID"
                ),
    XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/Name' 
            PASSING  cadoc AS "cadoc"),
    XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/DateOfBirth' 
            PASSING  cadoc AS "cadoc"),
    XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/Gender' 
            PASSING  cadoc AS "cadoc"),
    XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/CountryOfResidence' 
            PASSING  cadoc AS "cadoc"),
    XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/CountryOfResidence' 
            PASSING  cadoc AS "cadoc"),
    XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/Addresses' 
            PASSING  cadoc AS "cadoc"),
    XMLQUERY (
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/EmailAddresses' 
            PASSING  cadoc AS "cadoc") 
    ) AS CustomerProfile 
FROM custacc 
WHERE XMLEXISTS
(
'declare default element namespace "http://tpox-benchmark.com/custacc";
$cadoc/Customer[@id=1002]' 
PASSING cadoc AS "cadoc"
) 

