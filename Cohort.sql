-- Customer Cohort Analysis

WITH FirstPurchase  AS(
	SELECT
		CustomerKey,
		MIN(OrderDate) AS FirstOrderDate
	FROM [AdventureWorksDW2025].[dbo].[FactInternetSales]
	--WHERE OrderDate BETWEEN '2013-01-01' AND '2013-12-29'
	GROUP BY CustomerKey
)
-------------------------------------------------
, SalesWithCohort AS(
	SELECT
		s.CustomerKey,
        s.OrderDate,
        s.SalesAmount,
        fp.FirstOrderDate
	FROM [AdventureWorksDW2025].[dbo].[FactInternetSales] s
	JOIN FirstPurchase fp
		ON s.CustomerKey = fp.CustomerKey
	WHERE s.OrderDate BETWEEN '2013-01-01' AND '2013-12-29'
	AND fp.FirstOrderDate BETWEEN '2013-01-01' AND '2013-12-31'
)
--------------------------------------------------
, CohortPrepared AS(
	SELECT
		CustomerKey,
		FORMAT(FirstOrderDate, 'yyyy-MM') AS CohortMonth,
		FORMAT(OrderDate, 'yyyy-MM') AS OrderMonth,
		DATEDIFF(MONTH, FirstOrderDate, OrderDate) AS MonthIndex,
		SalesAmount
	FROM SalesWithCohort
)
-----------------------------------------------
, CohortSize AS (
    SELECT
        CohortMonth,
        COUNT(DISTINCT CustomerKey) AS CohortSize
    FROM CohortPrepared
    WHERE MonthIndex = 0
    GROUP BY CohortMonth
)
----------------------------------------------------
SELECT
	cp.CohortMonth,
	cp.MonthIndex,
	COUNT(DISTINCT cp.CustomerKey) AS ActiveCustomer,
	SUM(cp.SalesAmount) AS Revenue,
	cs.CohortSize,
	CAST(
		1.0 * COUNT(DISTINCT cp.CustomerKey) / cs.CohortSize
		AS decimal(5,2)
	) AS RetentionRate
FROM CohortPrepared cp
JOIN CohortSize cs
	ON cp.CohortMonth = cs.CohortMonth
GROUP BY
	cp.CohortMonth,
	cp.MonthIndex,
	cs.CohortSize
ORDER BY
	cp.CohortMonth,
	cp.MonthIndex
