Select*
from [dbo].[Stock_500]
Select*
from AVG_MONTH

--- Top tăng trưởng cao nhất
CREATE VIEW TOP_TANG AS
SELECT TOP 1 
    [date],
    [Name],
    [open],
    [close],
    ROUND(([close] - [open]) / [open] * 100, 2) AS tyle_tang
FROM [dbo].[Stock_500]
ORDER BY tyle_tang DESC;

-- Giá đóng cửa trung bình tháng của mỗi mã 
CREATE VIEW AVG_MONTH
AS 
	SELECT
		date,
		Name ,
		ROUND(AVG([close]), 2) AS avg_close_price
	FROM dbo.Stock_500
	GROUP BY date, Name
GO

-- Mức tăng trưởng cao nhất
CREATE VIEW AVG_MONTH
AS 
	SELECT
		date,
		Name ,
		ROUND(AVG([close]), 2) AS avg_close_price
	FROM dbo.Stock_500
	GROUP BY date, Name
GO

-- So sánh tăng trưởng giá của 3 mã bất kỳ theo quý

WITH price_by_quarter AS (
    SELECT
        DATEPART(YEAR, date) AS year,
        DATEPART(QUARTER, date) AS quarter,
        Name,
        MIN(date) AS start_date,
        MAX(date) AS end_date
    FROM dbo.Stock_500
    WHERE Name IN ('AAPL', 'MSFT', 'TSLA')
    GROUP BY DATEPART(YEAR, date), DATEPART(QUARTER, date), Name
),
price_change AS (
    SELECT
        pq.year,
        pq.quarter,
        pq.Name,
        s_open.[close] AS open_price,
        s_close.[close] AS close_price,
        ROUND(((s_close.[close] - s_open.[close]) / s_open.[close]) * 100, 2) AS pct_change
    FROM price_by_quarter pq
    JOIN dbo.Stock_500 s_open ON s_open.Name = pq.Name AND s_open.date = pq.start_date
    JOIN dbo.Stock_500 s_close ON s_close.Name = pq.Name AND s_close.date = pq.end_date
)
SELECT * 
FROM price_change
ORDER BY year, quarter, Name;

-- Phiên có khối lượng giao dịch tăng đột biến
WITH avg_volume AS (
    SELECT Name AS ticker, AVG(CAST(volume AS FLOAT)) AS avg_vol
    FROM dbo.Stock_500
    GROUP BY Name
)
SELECT 
    s.date,
    s.Name AS ticker,
    s.volume,
    ROUND(a.avg_vol, 0) AS avg_volume,
    ROUND(100.0 * CAST(s.volume AS FLOAT) / a.avg_vol, 2) AS volume_ratio
FROM dbo.Stock_500 s
JOIN avg_volume a ON s.Name = a.ticker
WHERE s.volume > 2 * a.avg_vol
ORDER BY volume_ratio DESC;


-- Top 5 mã có hiệu suất tốt nhất trong 6 tháng gần nhất
WITH last_date AS (
    SELECT MAX(date) AS max_date 
	FROM dbo.Stock_500
),
six_months_data AS (
    SELECT *
    FROM dbo.Stock_500
    WHERE date >= DATEADD(MONTH, -6, (SELECT max_date FROM last_date))
),
growth_table AS (
    SELECT
        Name AS ticker,
        MIN(date) AS first_day,
        MAX(date) AS last_day
    FROM six_months_data
    GROUP BY Name
),
growth_final AS (
    SELECT
        g.ticker,
        s1.[close] AS start_price,
        s2.[close] AS end_price,
        ROUND(((s2.[close] - s1.[close]) / s1.[close]) * 100.0, 2) AS pct_growth
    FROM growth_table g
    JOIN dbo.Stock_500 s1 ON s1.Name = g.ticker AND s1.date = g.first_day
    JOIN dbo.Stock_500 s2 ON s2.Name = g.ticker AND s2.date = g.last_day
)
SELECT TOP 5 * 
FROM growth_final
ORDER BY pct_growth DESC;


-- Biến động theo tuần – có tuần nào vượt biên độ 5% không?
WITH weekly_prices AS (
    SELECT
        DATEPART(YEAR, date) AS year,
        DATEPART(WEEK, date) AS week,
        Name AS ticker,
        MIN([low]) AS min_price,
        MAX([high]) AS max_price
    FROM dbo.Stock_500
    GROUP BY DATEPART(YEAR, date), DATEPART(WEEK, date), Name
),
weekly_volatility AS (
    SELECT *,
        ROUND(((max_price - min_price) / NULLIF(min_price, 0)) * 100.0, 2) AS volatility_pct
    FROM weekly_prices
)
SELECT *
FROM weekly_volatility
WHERE volatility_pct > 5
ORDER BY volatility_pct DESC;
