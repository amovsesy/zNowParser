------------------------------------------------------------------------
--  (C) Copyright IBM Corp. 2006
--
--  This program is made available under the terms of the Common Public 
--  License 1.0 as published by the Open Source Initiative (OSI). 
--  http://www.opensource.org/licenses/cpl1.0.php
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Return the securities on each account of the specified customer.
-- Show the ID and the balance of each account (the balance is
-- shown as an attribute, rather than an element).
-- The holdings are grouped by customer account.
-- (Customer can have several accounts and each account can have
-- several holdings.)
------------------------------------------------------------------------

-- Not able to be implemented in DB2 zOS. Should be supported once XMLTable function
-- is available.
-- As the first step, we extract all the accounts together. 

SELECT 
    XMLELEMENT(
        Name "Customer",
        XMLQUERY(
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/@id' 
            PASSING cadoc AS "cadoc"),
        XMLQUERY(
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/Name' 
            PASSING cadoc AS "cadoc"),
        XMLQUERY(
            'declare default element namespace "http://tpox-benchmark.com/custacc";
            $cadoc/Customer/Accounts/Account' 
            PASSING cadoc AS "cadoc")
    )
FROM custacc
WHERE XMLEXISTS
(
'declare default element namespace "http://tpox-benchmark.com/custacc";
$cadoc/Customer[@id=1011]'
PASSING cadoc AS "cadoc"
) 

--SELECT XMLQUERY
--(
--'declare default element namespace "http://tpox-benchmark.com/custacc";
--
--for $cust in $cadoc/Customer
--return
--	<Customer>{$cust/@id}
--		{$cust/Name}
--		<Customer_Securities>
--			{
--			 for $account in $cust/Accounts/Account	
--			 return 
--				<Account BALANCE="{$account/Balance/OnlineActualBal}" ACCOUNT_ID="{$account/@id}">
--					<Securities>
--						{$account/Holdings/Position/Name}
--					</Securities>
--				</Account>
--			}
--		</Customer_Securities>
--	</Customer>
--'
--PASSING cadoc AS "cadoc"
--)
--FROM custacc
--WHERE XMLEXISTS
--(
--'declare default element namespace "http://tpox-benchmark.com/custacc";
--$cadoc/Customer[@id=1011]'
--PASSING cadoc AS "cadoc"
--) 
