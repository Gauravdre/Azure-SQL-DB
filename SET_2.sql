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

select OrderDate, sum(SalesAmount)
from FactInternetSales
group by OrderDate
order by Sum(salesAmount) desc

-- simple aggregations
-- Use additional aggregations to understand more about product sales such as distribution of sales etc..
SELECT 
		cat.EnglishProductCategoryName 'Category'
    ,	sub.EnglishProductSubcategoryName 'SubCategory'
	,	count(1) 'Count' -- How many sales where there?
	,	sum(s.SalesAmount) 'Sales' -- How much sales did we have?
    ,	avg(s.SalesAmount) 'Avg_SalesAmount' -- What was the Avg sale amount?
    ,	min(s.SalesAmount) 'Min_SaleAmount' -- What was the Min sale amount?
    ,	max(s.SalesAmount) 'Max_SaleAmount' -- What was the Max sale amount
FROM FactInternetSales s
LEFT JOIN DimProduct p ON s.ProductKey = p.ProductKey
LEFT JOIN DimProductSubcategory sub ON p.ProductSubcategoryKey = sub.ProductSubcategoryKey
LEFT JOIN DimProductCategory cat ON sub.ProductCategoryKey = cat.ProductCategoryKey
-- must use group by in order for aggregation to work properly
GROUP BY
		cat.EnglishProductCategoryName -- column aliases aren't allowed
    ,	sub.EnglishProductSubcategoryName
ORDER BY
		cat.EnglishProductCategoryName
	,	sub.EnglishProductSubcategoryName

-- Year 2013 and Product Category/ Product subcategory wise.
SELECT 
		YEAR(s.OrderDate) 'Year'
	,	cat.EnglishProductCategoryName 'Category'
    ,	sub.EnglishProductSubcategoryName 'SubCategory'	
	,	count(1) 'Count' -- use 1 instead of a field for faster performance
	,	sum(s.SalesAmount) 'Sales'
    ,	avg(s.SalesAmount) 'Avg_Quantity'
    ,	min(s.SalesAmount) 'Min_SaleAmount'
    ,	max(s.SalesAmount) 'Max_SaleAmount'

FROM FactInternetSales s
INNER JOIN DimProduct p ON s.ProductKey = p.ProductKey
INNER JOIN DimProductSubcategory sub ON p.ProductSubcategoryKey = sub.ProductSubcategoryKey
INNER JOIN DimProductCategory cat ON sub.ProductCategoryKey = cat.ProductCategoryKey
-- filter
WHERE YEAR(s.OrderDate) = 2013 --use date function to parse year
-- must use group by in order for aggregation to work properly
GROUP BY
		YEAR(s.OrderDate)
	,	cat.EnglishProductCategoryName -- column aliases aren't allowed
    ,	sub.EnglishProductSubcategoryName
ORDER BY
		cat.EnglishProductCategoryName
	,	sub.EnglishProductSubcategoryName