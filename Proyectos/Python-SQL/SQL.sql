/*CREATE TABLE df_orders(
	[order_id] INT PRIMARY KEY,
	[order_date] DATE,
	[ship_mode] VARCHAR(20),
	[segment] VARCHAR(20),
	[country] VARCHAR(20),
	[city] VARCHAR(20),
	[state] VARCHAR(20),
	[postal_code] VARCHAR(20),
	[region] VARCHAR(20),
	[category] VARCHAR(20),
	[sub_category] VARCHAR(20),
	[product_id] VARCHAR(20),
	[quantity] INT,
	[discount] DECIMAL(7,2),
	[sale_price] DECIMAL(7,2),
	[profit] DECIMAL(7,2)
	)
	*/
/*top 10 de ventas*/
/*SELECT TOP 10 product_id, sum(sale_price) as sales
FROM df_orders
GROUP BY product_id
ORDER BY sales DESC*/
/*TOP 5 PRODUCTOS MAS VENDIDOS POR REGION*/
--WITH CTE AS(
--SELECT region,product_id, sum(sale_price) as sales
--FROM df_orders
--GROUP BY region, product_id
--)
--SELECT * FROM(
--SELECT *,
--ROW_NUMBER() OVER (PARTITION BY region ORDER BY sales DESC) AS rn
--FROM CTE) A
--WHERE rn<=5;

--FIND MONTH OVER MONTH GROWTH COMPARISON

--WITH CTE AS(
--SELECT year(order_date) as order_year, month(order_date) as order_month,
--sum(sale_price) as sales
--FROM df_orders
--group by year(order_date), month(order_date)
----order by year(order_date), month(order_date)
--)
--SELECT order_month,
--SUM(CASE WHEN order_year=2022 THEN sales ELSE 0 END) AS sales_2022,
--SUM(CASE WHEN order_year=2023 THEN sales ELSE 0 END) AS sales_2023
--FROM CTE
--group by order_month
--order by order_month

--PARA CADA CATEGORIA, CUAL MES TUVO LAS VENTAS MAS ALTAS
--WITH CTE AS(
--SELECT category, sum(sale_price) as sales, format(order_date, 'yyyyMM') as order_year_month

--FROM df_orders
--group by category, format(order_date, 'yyyyMM')
----order by category,format(order_date, 'yyyyMM')
--)
--SELECT * FROM(
--SELECT *,
--ROW_NUMBER() over(partition by category order by sales desc) as rn
--FROM CTE) a
--WHERE rn=1


--CUAL SUBCATEGORIA TUVO EL CRECIMIENTO MAS ALTO POR INGRESO EN 2023 COMPARADO AL 2022
WITH CTE AS(
SELECT sub_category, year(order_date) as order_year,
sum(sale_price) as sales
FROM df_orders
group by year(order_date), sub_category
--order by year(order_date), month(order_date)
)
, CTE2 AS(
SELECT sub_category,
SUM(CASE WHEN order_year=2022 THEN sales ELSE 0 END) AS sales_2022,
SUM(CASE WHEN order_year=2023 THEN sales ELSE 0 END) AS sales_2023
FROM CTE
group by sub_category
)

SELECT TOP 1 *,
(sales_2023-sales_2022)*100/sales_2022 as crecimiento
FROM CTE2
order by (sales_2023-sales_2022)*100/sales_2022 desc


SELECT DISTINCT sub_category from df_orders
ORDER BY sub_category
