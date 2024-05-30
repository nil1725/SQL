/*
1.define the variables
2. create a CTE THAT ROUNDS THE AVERAGEE VIEWS PER VIDEO
3. SELECT THE COLUMNS THAT ARE REQUIRED FOR THE ANALYSIS
4. filter the results by the youtube channels with the highest subscriber bases.
5. order by net_profit (from highest to lowest)


*/
-- 1. DECLARE VARIABLES
DECLARE @conversionRate FLOAT= 0.02;
DECLARE @productCost MONEY= 5.0;
DECLARE @campaignCost MONEY= 50000.0;


-- 2. CTE

WITH ChannelData AS (
	SELECT
	channel_name,
	total_subscribers,
	total_views,
	total_videos,
	ROUND((CAST(total_views as FLOAT)/total_videos), -4) AS rounded_avg_views_per_video,
	(total_views/total_videos) AS original_avg_views_per_video
	FROM
	youtubers_db.dbo.view_uk_youtubers_2024
)
-- SELECT * FROM ChannelData

-- 3. SELECT COLUMNS
-- SELECT * FROM ChannelData
-- WHERE channel_name IN ('NoCopyRightSounds', 'DanTDM', 'Dan Rhodes')
-- 4.
SELECT
	channel_name,
	rounded_avg_views_per_video,
	(rounded_avg_views_per_video*@conversionRate) as potential_units_sold_per_video,
	(rounded_avg_views_per_video*@conversionRate*@productCost) as potential_revenue_per_video,
	(rounded_avg_views_per_video*@conversionRate*@productCost) - @campaignCost as net_profit

FROM ChannelData
WHERE channel_name IN ('NoCopyRightSounds', 'DanTDM', 'Dan Rhodes')
-- 5. ORDER BY PROFIT
ORDER BY
	net_profit DESC

