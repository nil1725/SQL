
-- USE youtubers_db;
/*
#data cleaning steps
1. Remove unnecesary columns selecting the ones we need.
2. Extract the Youtube channel names in the first column.
3. Rename the column names.
*/
CREATE VIEW view_uk_youtubers_2024 AS
SELECT
	CAST((SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE)-1)) AS VARCHAR(100)) as channel_name,
	total_subscribers,
	total_views,
	total_videos
FROM 
	top_uk_youtubers_2024;
-- SELECT 
-- 	NOMBRE,
--     total_subscribers,
--     total_views,
--     total_videos
-- FROM 
-- 	top_uk_youtubers_2024;
