use AdventureWorksDW2019;


-- inner join
-- returns results only where the join condition is true
select top 1000 *
from FactInternetSales s
inner join DimProduct p on s.ProductKey = p.ProductKey

-- left join
-- returns all rows from sales, regardless of the join condition
select distinct EnglishProductName
from FactInternetSales s
left join DimProduct p on s.ProductKey = p.ProductKey
order by 1

-- add filter conditions to join
select *
from FactInternetSales s
inner join DimProduct p 
	on	s.ProductKey = p.ProductKey 
	and	p.StartDate > '2013-01-01'
	
-- basic filter with WHERE
-- get sales of a specific product only
SELECT *
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE p.EnglishProductName = 'Road-650 Black, 62'

-- non-equi-filters
-- get all orders for 2013
SELECT *
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE	s.OrderDate >= '2013-01-01'
AND		s.OrderDate <= '2013-12-31'

-- also can use "between" for dates
SELECT *
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE s.OrderDate BETWEEN '2013-01-01' AND '2013-12-31';

-- filter for multiple values using IN
SELECT *
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE p.EnglishProductName in( 
		'Road-150 Red, 48',
		'Road-150 Red, 52',
		'Road-150 Red, 62',
		'Road-150 Red, 56')


-- find all current and future matches with LIKE
SELECT *
FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
WHERE p.EnglishProductName LIKE 'Road%' --put % where you want wildcard