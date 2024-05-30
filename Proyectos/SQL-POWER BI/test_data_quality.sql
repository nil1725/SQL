/*
#DATA QUALITY TESTS
1. the data needs to be 100 records of youtube channels (row count test)....passed
2. The data needs 4 fields (column count test)....passed
3. The channel name column must be string format, and the other columns 
must be numerical data types (data type check)....passed
4. Each record must be unique in the dataset (duplicate count check)

WE ARE EXPECTING
 records or number of rows: 100
 columns: 4
 DATA TYPES
  channel_name: CHAR(100), VARCHAR
  total_subscribers: INTEGER
  total_views: INTEGER
  total_videos: INTEGER
  
  duplicate count; 0
*/

-- 1. Row count check
SELECT COUNT(*) as N_filas
FROM view_uk_youtubers_2024

-- 2. Column count check
SELECT COUNT(*) AS total_columnas 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'view_uk_youtubers_2024';

-- 3. Data types check
SELECT
	COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='view_uk_youtubers_2024';

-- 4. Duplicate records check 
SELECT channel_name,
		COUNT(*) as duplicate_count
FROM view_uk_youtubers_2024
GROUP BY
	channel_name
HAVING
	COUNT(*)>1;
