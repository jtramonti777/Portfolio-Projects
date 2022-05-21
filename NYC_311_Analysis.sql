----------------------------------------------------------------------------------------------------------------
--NYC 311 Analysis Queries
--Each query outputs to a table in the Tables section of the Contents sheet in Excel and is labelled accordingly
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
--Year--
----------------------------------------------------------------------------------------------------------------
--Request count, avg and median time to close by year excluding 2020 as it is incomplete
SELECT
	'2019' AS Year,
	--Request_id count
	COUNT(request_id),
	--Average time to close
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	--Median time to close
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS median_time_to_close
	
FROM public.nyc_311_2019

UNION

SELECT
	'2018' AS Year,
	COUNT(request_id),
	--Average time to close
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	--Median time to close
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS median_time_to_close

FROM public.nyc_311_2018

UNION

SELECT
	'2017' AS Year,
	COUNT(request_id),
	--Average time to close
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	--Median time to close
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS median_time_to_close
	
FROM public.nyc_311_2017

UNION

SELECT
	'2016' AS Year,
	COUNT(request_id),
	--Average time to close
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	--Median time to close
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS median_time_to_close
	
FROM public.nyc_311_2016
--Put years in chronological order
ORDER BY Year
;
----------------------------------------------------------------------------------------------------------------
--Month--
----------------------------------------------------------------------------------------------------------------
--Count of requests for each month 2016-2020, with avg and median time to close and most frequent request type and agency
SELECT
	--Month written out as word
	TO_CHAR(created_date, 'Month') AS Month,
	--Month as number
	EXTRACT(MONTH FROM created_date) AS month_number,
	'2020' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		--Use yearly average if time to close less than 1 because of outliers
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 1
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common requesttype
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common responsibleagency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2020
GROUP BY 1, 2

UNION

SELECT
	--Month written out as word
	TO_CHAR(created_date, 'Month') AS Month,
	--Month as number
	EXTRACT(MONTH FROM created_date) AS month_number,
	'2019' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		--Use yearly average if time to close less than 1 because of outliers
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 1
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common requesttype
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common responsibleagency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2019
GROUP BY 1, 2

UNION

SELECT
	--Month written out as word
	TO_CHAR(created_date, 'Month') AS Month,
	--Month as number
	EXTRACT(MONTH FROM created_date) AS month_number,
	'2018' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		--Use yearly average if time to close less than 1 because of outliers
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 1
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common requesttype
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common responsibleagency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2018
GROUP BY 1, 2

UNION

SELECT
	--Month written out as word
	TO_CHAR(created_date, 'Month') AS Month,
	--Month as number
	EXTRACT(MONTH FROM created_date) AS month_number,
	'2017' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		--Use yearly average if time to close less than 1 because of outliers
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 1
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common requesttype
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common responsibleagency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2017
GROUP BY 1, 2

UNION

SELECT
	--Month written out as word
	TO_CHAR(created_date, 'Month') AS Month,
	--Month as number
	EXTRACT(MONTH FROM created_date) AS month_number,
	'2016' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		--Use yearly average if time to close less than 1 because of outliers
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 1
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common requesttype
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common responsibleagency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2016
GROUP BY 1, 2
--Order by year and month chronologically
ORDER BY year, month_number
;
----------------------------------------------------------------------------------------------------------------
--Hour--
----------------------------------------------------------------------------------------------------------------
--Request Count by hour of day with avg and median time to close, most frequent requesttype and responsibleagency 
SELECT	
	DISTINCT(
		--Extract hour from created_date
		EXTRACT(HOUR FROM created_date)) AS Hour,
	'2020' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common request type
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common agency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2020
GROUP BY 1, 2

UNION

SELECT	
	DISTINCT(
		--Extract hour from created_date
		EXTRACT(HOUR FROM created_date)) AS Hour,
	'2019' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common request type
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common agency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2019
GROUP BY 1, 2

UNION

SELECT	
	DISTINCT(
		--Extract hour from created_date
		EXTRACT(HOUR FROM created_date)) AS Hour,
	'2018' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common request type
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common agency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2018
GROUP BY 1, 2

UNION

SELECT	
	DISTINCT(
		--Extract hour from created_date
		EXTRACT(HOUR FROM created_date)) AS Hour,
	'2017' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common request type
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common agency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2017
GROUP BY 1, 2

UNION

SELECT	
	DISTINCT(
		--Extract hour from created_date
		EXTRACT(HOUR FROM created_date)) AS Hour,
	'2016' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average if time to close null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median if time to close null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	--Most common request type
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_request,
	--Most common agency
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
FROM public.nyc_311_2016
GROUP BY 1, 2
--Order by year and hour of day chronologically
ORDER BY year, hour
;
----------------------------------------------------------------------------------------------------------------
--Time_to_Close--
----------------------------------------------------------------------------------------------------------------
--Number of requests by unique time to close in days with most common requesttype and responsible agency
SELECT 
	'2020' AS Year,
	COUNT(request_id),
	(closed_date::date - created_date::date) AS time_to_close,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
 	
	
FROM public.nyc_311_2020
--Exclude null values 
WHERE (closed_date::date - created_date::date) IS NOT NULL 
--Exclude negative time to close
AND (closed_date::date - created_date::date) >= 0
--Limit highest time to close values to make graph visible
AND (closed_date::date - created_date::date) <= 64
GROUP BY 3

UNION

SELECT 
	'2019' AS Year,
	COUNT(request_id),
	(closed_date::date - created_date::date) AS time_to_close,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
 	
	
FROM public.nyc_311_2019
--Exclude null values
WHERE (closed_date::date - created_date::date) IS NOT NULL 
--Exclude negative time to close
AND (closed_date::date - created_date::date) >= 0
--Limit highest time to close values to make graph visible
AND (closed_date::date - created_date::date) <= 64
GROUP BY 3

UNION

SELECT 
	'2018' AS Year,
	COUNT(request_id),
	(closed_date::date - created_date::date) AS time_to_close,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
 	
	
FROM public.nyc_311_2018
--Exclude null values
WHERE (closed_date::date - created_date::date) IS NOT NULL 
--Exclude negative time to close
AND (closed_date::date - created_date::date) >= 0
--Limit highest time to close values to make graph visible
AND (closed_date::date - created_date::date) <= 64
GROUP BY 3

UNION

SELECT 
	'2017' AS Year,
	COUNT(request_id),
	(closed_date::date - created_date::date) AS time_to_close,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
 	
	
FROM public.nyc_311_2017
--Exclude null values
WHERE (closed_date::date - created_date::date) IS NOT NULL 
--Exclude negative time to close
AND (closed_date::date - created_date::date) >= 0
--Limit highest time to close values to make graph visible
AND (closed_date::date - created_date::date) <= 64
GROUP BY 3

UNION

SELECT 
	'2016' AS Year,
	COUNT(request_id),
	(closed_date::date - created_date::date) AS time_to_close,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
 	
	
FROM public.nyc_311_2016
--Exclude null values
WHERE (closed_date::date - created_date::date) IS NOT NULL 
--Exclude negative time to close
AND (closed_date::date - created_date::date) >= 0
--Limit highest time to close values to make graph visible
AND (closed_date::date - created_date::date) <= 64
GROUP BY 3
--Order by year chronologically
ORDER BY year, time_to_close
;
----------------------------------------------------------------------------------------------------------------
--Time_to_Close--
----------------------------------------------------------------------------------------------------------------
--Number of requests by unique time to close in hours with most common requesttype and responsible agency
SELECT 
	'2020' AS Year,
	COUNT(request_id),
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) AS time_to_close_hours,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
	 
FROM public.nyc_311_2020
--Exclude null values
WHERE ((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) IS NOT NULL AND
	--Exclude negative time to close
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) >=0 AND
	--Limit highest time to close values to make graph visible
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) <=24
GROUP BY 3

UNION

SELECT 
	'2019' AS Year,
	COUNT(request_id),
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) AS time_to_close_hours,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
	 
FROM public.nyc_311_2019
--Exclude null values
WHERE ((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) IS NOT NULL AND
	--Exclude negative time to close
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) >=0 AND
	--Limit highest time to close values to make graph visible
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) <=24
GROUP BY 3

UNION

SELECT 
	'2018' AS Year,
	COUNT(request_id),
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) AS time_to_close_hours,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
	 
FROM public.nyc_311_2018
--Exclude null values
WHERE ((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) IS NOT NULL AND
	--Exclude negative time to close
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) >=0 AND
	--Limit highest time to close values to make graph visible
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) <=24
GROUP BY 3

UNION

SELECT 
	'2017' AS Year,
	COUNT(request_id),
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) AS time_to_close_hours,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
	 
FROM public.nyc_311_2017
--Exclude null values
WHERE ((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) IS NOT NULL AND
	--Exclude negative time to close
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) >=0 AND
	--Limit highest time to close values to make graph visible
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) <=24
GROUP BY 3

UNION

SELECT 
	'2016' AS Year,
	COUNT(request_id),
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) AS time_to_close_hours,
	MODE() WITHIN GROUP (ORDER BY requesttype) AS mode_requestype,
	MODE() WITHIN GROUP (ORDER BY responsibleagency) AS mode_agency
	 
FROM public.nyc_311_2016
--Exclude null values
WHERE ((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) IS NOT NULL AND
	--Exclude negative time to close
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) >=0 AND
	--Limit highest time to close values to make graph visible
	((EXTRACT(hour FROM (closed_date)) - (EXTRACT(hour from created_date)))) <=24
GROUP BY 3
--Order by year chronologically
ORDER BY year, time_to_close_hours
;
----------------------------------------------------------------------------------------------------------------
--Request_Type--
----------------------------------------------------------------------------------------------------------------
--Unique request types with respective count, average and median time to close
SELECT
	--Lowercase request types in all caps
	CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END AS request_type,
	'2020' AS Year,
	COUNT(request_id),
	--Use year average time to close if null
	CASE WHEN
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		--Use year average time to close if null
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	
	CASE WHEN 
		--Use median time to close for the year if Null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2020
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%' 
GROUP BY 1


UNION


SELECT
	--Lowercase request types in all caps
	CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END AS request_type,
	'2019' AS Year,
	COUNT(request_id),
	--Use year average time to close if null
	CASE WHEN
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		--Use year average time to close if null
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	
	CASE WHEN 
		--Use median time to close for the year if Null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2019
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%' 
GROUP BY 1

UNION

SELECT
	--Lowercase request types in all caps
	CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END AS request_type,
	'2018' AS Year,
	COUNT(request_id),
	--Use year average time to close if null
	CASE WHEN
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		--Use year average time to close if null
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	
	CASE WHEN 
		--Use median time to close for the year if Null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2019
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%' 
GROUP BY 1

UNION

SELECT
	--Lowercase request types in all caps
	CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END AS request_type,
	'2017' AS Year,
	COUNT(request_id),
	--Use year average time to close if null
	CASE WHEN
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		--Use year average time to close if null
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	
	CASE WHEN 
		--Use median time to close for the year if Null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2017
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%' 
GROUP BY 1

UNION

SELECT
	--Lowercase request types in all caps
	CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END AS request_type,
	'2016' AS Year,
	COUNT(request_id),
	--Use year average time to close if null
	CASE WHEN
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		--Use year average time to close if null
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	
	CASE WHEN 
		--Use median time to close for the year if Null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2016
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%' 
GROUP BY 1
--Order by year chronologically
ORDER BY Year
;
-----------------------------------------------------------------------------------------------------------------
--Request_Type--
-----------------------------------------------------------------------------------------------------------------
--Most common category of request by unique request type
--Count, average time to close, median time to close and most common month, day and hour for that category
--NOTE: THE RESULTS OF THIS QUERY WERE NOT USED IN THE ANALYSIS AS I COULD NOT MAKE AN EFFECTIVE VISUALIZATION FOR THEM--
--DOES NOT APPEAR IN THE EXCEL WORKBOOK--
SELECT
	DISTINCT(CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END) AS request_type,
	'2020' AS Year,
	--Return most frequent category in request type, if N/A use request type
	MODE() WITHIN GROUP (ORDER BY (
		SELECT 
			DISTINCT
			(CASE 
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
			 COUNT(request_id),
			 
			 CASE WHEN
				ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
				THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
				ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
			END AS avg_time_to_close,
			CASE WHEN 
				PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
				THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
				ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
			END AS median_time_to_close,
			
			MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
			
FROM public.nyc_311_2020
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%'
GROUP BY 1


UNION

SELECT
	DISTINCT(CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END) AS request_type,
	'2019' AS Year,
	--Return most frequent category in request type, if N/A use request type
	MODE() WITHIN GROUP (ORDER BY (
		SELECT 
			DISTINCT
			(CASE 
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
			 COUNT(request_id),
			 
			 CASE WHEN
				ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
				THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
				ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
			END AS avg_time_to_close,
			CASE WHEN 
				PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
				THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
				ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
			END AS median_time_to_close,
			
			MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
			
FROM public.nyc_311_2019
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%'
GROUP BY 1


UNION

SELECT
	DISTINCT(CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END) AS request_type,
	'2018' AS Year,
	--Return most frequent category in request type, if N/A use request type
	MODE() WITHIN GROUP (ORDER BY (
		SELECT 
			DISTINCT
			(CASE 
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
			 COUNT(request_id),
			 
			 CASE WHEN
				ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
				THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
				ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
			END AS avg_time_to_close,
			CASE WHEN 
				PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
				THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)
				ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
			END AS median_time_to_close,
			 
			MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
			
FROM public.nyc_311_2018
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%'
GROUP BY 1

UNION

SELECT
	DISTINCT(CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END) AS request_type,
	'2017' AS Year,
	--Return most frequent category in request type, if N/A use request type
	MODE() WITHIN GROUP (ORDER BY (
		SELECT 
			DISTINCT
			(CASE 
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
			 COUNT(request_id),
			 
			 CASE WHEN
				ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
				THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
				ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
			END AS avg_time_to_close,
			CASE WHEN 
				PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
				THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
				ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
			END AS median_time_to_close,
			
			MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
			
FROM public.nyc_311_2017
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%'
GROUP BY 1

UNION

SELECT
	DISTINCT(CASE WHEN
		LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
		ELSE requesttype
    END) AS request_type,
	'2016' AS Year,
	--Return most frequent category in request type, if N/A use request type
	MODE() WITHIN GROUP (ORDER BY (
		SELECT 
			DISTINCT
			(CASE 
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
			 COUNT(request_id),
			 
			 CASE WHEN
				ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
				THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
				ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
			END AS avg_time_to_close,
			CASE WHEN 
				PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
				THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
				ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
			END AS median_time_to_close,
			
			MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
			MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
			
FROM public.nyc_311_2016
WHERE 
	--Exclude non letter and miscellaneous request types
	LEFT(requesttype, 1) ~ '^[A-Z]+$' AND 
	LEFT(requesttype, 4) NOT ILIKE '%Misc%'
GROUP BY 1
--Order by request type and category with the highest request count
ORDER BY count DESC
;
-----------------------------------------------------------------------------------------------------------------
--Agency--
-----------------------------------------------------------------------------------------------------------------
--Unique agency code and name, count of requests, average and median time to close and most common request type and category
--Most common month the agency recieves requests 
--NOTE: Did post query data cleaning in excel to get the most common month written out as text
--NOTE: Data cleaning for the agencies involved specifying many sub agencies and classifying them under their parent agency. 
--This query takes a bit longer to run
--2020--
SELECT
	DISTINCT(agency_code),
	CASE 
		--Consolidate different sub agencies into a single count for an agency
		WHEN responsibleagency LIKE '%HealthCare Connections%' THEN 'Department for the Aging'
		WHEN responsibleagency LIKE '%Operations Unit - Department of Homeless Services%' THEN 'Department of Homeless Services'
		WHEN LEFT(responsibleagency, 4) LIKE '%Mosq%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Chil%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Adju%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Comm%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Cond%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disa%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Exte%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Land%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Correspondence Unit%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Sheriff' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Dunn%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Taxpayer Advocate%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Paym%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Pers%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Prop%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Refu%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%RPIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Seni%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disc%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Reve%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Valu%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the CIO - Department of Education%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 10) LIKE '%Central - %' THEN 'Department of Education'
		WHEN responsibleagency LIKE '%Alternative Superintendency%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 9) LIKE '%School - %' THEN 'Department of Education'
		WHEN (RIGHT(responsibleagency, 2) !~* '^[A-Z]+$') AND responsibleagency NOT LIKE '%3-1-1%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 3) LIKE '%BCC%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%A - %' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%P - %' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Lot Cleaning%' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Fire Department Operations Center%' THEN 'Fire Department of New York'
		WHEN LEFT(responsibleagency, 4) LIKE '%Link%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 4) LIKE '%Traf%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 4) LIKE '%Inve%' THEN 'New York City Police Department' 
		WHEN responsibleagency LIKE '%Correspondence - Taxi and Limousine Commission%' THEN 'Taxi and Limousine Commission'
		WHEN responsibleagency LIKE '%3-1-1%' THEN '3-1-1 Call Center'
		WHEN responsibleagency LIKE '%NYCEM Property Damage%' THEN 'NYC Emergency Management'
		
		--Write out any abbreviated agency names
		WHEN LEFT(responsibleagency, 3) LIKE '%ACS%' THEN 'Administration for Children''s services'
		WHEN LEFT(responsibleagency, 3) LIKE '%CEO%' THEN 'Center for Employment'
		WHEN LEFT(responsibleagency, 4) LIKE '%DFTA%' THEN 'Department for the Aging'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOB%' THEN 'Department of Buildings'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOE%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOF%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%DRIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 5) LIKE '%DoITT%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOT%' THEN 'Department of Transportation'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCA%' THEN 'Department of Consumer Affairs'
		WHEN LEFT(responsibleagency, 3) LIKE '%DPR%' THEN 'Department of Parks and Recreation'
		WHEN LEFT(responsibleagency, 4) LIKE '%COIB%' THEN 'Conflice of Interest Board'
		WHEN LEFT(responsibleagency, 4) LIKE '%DCAS%' THEN 'Department of Citywide Adminstrative Services'
		WHEN LEFT(responsibleagency, 5) LIKE '%DOHMH%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCP%' THEN 'Department of City Planning'
		WHEN LEFT(responsibleagency, 4) LIKE '%NYPD%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 3) LIKE '%DVS%' THEN 'Department of Verteran''s Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%MOC%' THEN 'Mayor''s Office of Contract Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%OMB%' THEN 'Office of the Mayoral Budget'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAX%' THEN 'New York City Tax Commission'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAT%' THEN 'Tourism Authority of Thailand'
		WHEN LEFT(responsibleagency, 3) LIKE '%TLC%' THEN 'Taxi and Limousine Commission'
		
		ELSE responsibleagency 
	END AS responsibleagency,
	'2020' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		--Use 0 when average time to close negative
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN 0
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case request types
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case categories
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
				
			
FROM public.nyc_311_2020
GROUP BY 1, 2

UNION
--2019--
SELECT
	DISTINCT(agency_code),
	CASE 
		--Consolidate different sub agencies into a single count for an agency
		WHEN responsibleagency LIKE '%HealthCare Connections%' THEN 'Department for the Aging'
		WHEN responsibleagency LIKE '%Operations Unit - Department of Homeless Services%' THEN 'Department of Homeless Services'
		WHEN LEFT(responsibleagency, 4) LIKE '%Mosq%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Chil%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Adju%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Comm%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Cond%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disa%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Exte%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Land%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Correspondence Unit%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Sheriff' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Dunn%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Taxpayer Advocate%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Paym%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Pers%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Prop%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Refu%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%RPIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Seni%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disc%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Reve%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Valu%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the CIO - Department of Education%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 10) LIKE '%Central - %' THEN 'Department of Education'
		WHEN responsibleagency LIKE '%Alternative Superintendency%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 9) LIKE '%School - %' THEN 'Department of Education'
		WHEN (RIGHT(responsibleagency, 2) !~* '^[A-Z]+$') AND responsibleagency NOT LIKE '%3-1-1%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 3) LIKE '%BCC%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%A - %' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%P - %' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Lot Cleaning%' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Fire Department Operations Center%' THEN 'Fire Department of New York'
		WHEN LEFT(responsibleagency, 4) LIKE '%Link%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 4) LIKE '%Traf%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 4) LIKE '%Inve%' THEN 'New York City Police Department' 
		WHEN responsibleagency LIKE '%Correspondence - Taxi and Limousine Commission%' THEN 'Taxi and Limousine Commission'
		WHEN responsibleagency LIKE '%3-1-1%' THEN '3-1-1 Call Center'
		WHEN responsibleagency LIKE '%NYCEM Property Damage%' THEN 'NYC Emergency Management'
		
		--Write out any abbreviated agency names
		WHEN LEFT(responsibleagency, 3) LIKE '%ACS%' THEN 'Administration for Children''s services'
		WHEN LEFT(responsibleagency, 3) LIKE '%CEO%' THEN 'Center for Employment'
		WHEN LEFT(responsibleagency, 4) LIKE '%DFTA%' THEN 'Department for the Aging'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOB%' THEN 'Department of Buildings'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOE%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOF%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%DRIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 5) LIKE '%DoITT%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOT%' THEN 'Department of Transportation'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCA%' THEN 'Department of Consumer Affairs'
		WHEN LEFT(responsibleagency, 3) LIKE '%DPR%' THEN 'Department of Parks and Recreation'
		WHEN LEFT(responsibleagency, 4) LIKE '%COIB%' THEN 'Conflice of Interest Board'
		WHEN LEFT(responsibleagency, 4) LIKE '%DCAS%' THEN 'Department of Citywide Adminstrative Services'
		WHEN LEFT(responsibleagency, 5) LIKE '%DOHMH%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCP%' THEN 'Department of City Planning'
		WHEN LEFT(responsibleagency, 4) LIKE '%NYPD%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 3) LIKE '%DVS%' THEN 'Department of Verteran''s Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%MOC%' THEN 'Mayor''s Office of Contract Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%OMB%' THEN 'Office of the Mayoral Budget'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAX%' THEN 'New York City Tax Commission'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAT%' THEN 'Tourism Authority of Thailand'
		WHEN LEFT(responsibleagency, 3) LIKE '%TLC%' THEN 'Taxi and Limousine Commission'
		
		ELSE responsibleagency 
	END AS responsibleagency,
	'2019' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		--Use 0 when average time to close negative
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN 0
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case request types
				WHEN LEFT(requesttype, 2) LIKE '%..%' THEN category
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case categories
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
				
			
FROM public.nyc_311_2019
GROUP BY 1, 2

UNION
--2018--
SELECT
	DISTINCT(agency_code),
	CASE 
		--Consolidate different sub agencies into a single count for an agency
		WHEN responsibleagency LIKE '%HealthCare Connections%' THEN 'Department for the Aging'
		WHEN responsibleagency LIKE '%Operations Unit - Department of Homeless Services%' THEN 'Department of Homeless Services'
		WHEN LEFT(responsibleagency, 4) LIKE '%Mosq%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Chil%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Adju%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Comm%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Cond%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disa%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Exte%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Land%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Correspondence Unit%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Sheriff' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Dunn%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Taxpayer Advocate%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Paym%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Pers%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Prop%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Refu%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%RPIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Seni%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disc%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Reve%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Valu%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the CIO - Department of Education%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 10) LIKE '%Central - %' THEN 'Department of Education'
		WHEN responsibleagency LIKE '%Alternative Superintendency%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 9) LIKE '%School - %' THEN 'Department of Education'
		WHEN (RIGHT(responsibleagency, 2) !~* '^[A-Z]+$') AND responsibleagency NOT LIKE '%3-1-1%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 3) LIKE '%BCC%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%A - %' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%P - %' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Lot Cleaning%' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Fire Department Operations Center%' THEN 'Fire Department of New York'
		WHEN LEFT(responsibleagency, 4) LIKE '%Link%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 4) LIKE '%Traf%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 4) LIKE '%Inve%' THEN 'New York City Police Department' 
		WHEN responsibleagency LIKE '%Correspondence - Taxi and Limousine Commission%' THEN 'Taxi and Limousine Commission'
		WHEN responsibleagency LIKE '%3-1-1%' THEN '3-1-1 Call Center'
		WHEN responsibleagency LIKE '%NYCEM Property Damage%' THEN 'NYC Emergency Management'
		
		--Write out any abbreviated agency names
		WHEN LEFT(responsibleagency, 3) LIKE '%ACS%' THEN 'Administration for Children''s services'
		WHEN LEFT(responsibleagency, 3) LIKE '%CEO%' THEN 'Center for Employment'
		WHEN LEFT(responsibleagency, 4) LIKE '%DFTA%' THEN 'Department for the Aging'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOB%' THEN 'Department of Buildings'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOE%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOF%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%DRIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 5) LIKE '%DoITT%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOT%' THEN 'Department of Transportation'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCA%' THEN 'Department of Consumer Affairs'
		WHEN LEFT(responsibleagency, 3) LIKE '%DPR%' THEN 'Department of Parks and Recreation'
		WHEN LEFT(responsibleagency, 4) LIKE '%COIB%' THEN 'Conflice of Interest Board'
		WHEN LEFT(responsibleagency, 4) LIKE '%DCAS%' THEN 'Department of Citywide Adminstrative Services'
		WHEN LEFT(responsibleagency, 5) LIKE '%DOHMH%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCP%' THEN 'Department of City Planning'
		WHEN LEFT(responsibleagency, 4) LIKE '%NYPD%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 3) LIKE '%DVS%' THEN 'Department of Verteran''s Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%MOC%' THEN 'Mayor''s Office of Contract Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%OMB%' THEN 'Office of the Mayoral Budget'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAX%' THEN 'New York City Tax Commission'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAT%' THEN 'Tourism Authority of Thailand'
		WHEN LEFT(responsibleagency, 3) LIKE '%TLC%' THEN 'Taxi and Limousine Commission'
		
		ELSE responsibleagency 
	END AS responsibleagency,
	'2018' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		--Use 0 when average time to close negative
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN 0
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case request types
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case categories
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
				
			
FROM public.nyc_311_2018
GROUP BY 1, 2

UNION
--2017--
SELECT
	DISTINCT(agency_code),
	CASE 
		--Consolidate different sub agencies into a single count for an agency
		WHEN responsibleagency LIKE '%HealthCare Connections%' THEN 'Department for the Aging'
		WHEN responsibleagency LIKE '%Operations Unit - Department of Homeless Services%' THEN 'Department of Homeless Services'
		WHEN LEFT(responsibleagency, 4) LIKE '%Mosq%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Chil%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Adju%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Comm%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Cond%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disa%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Exte%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Land%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Correspondence Unit%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Sheriff' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Dunn%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Taxpayer Advocate%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Paym%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Pers%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Prop%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Refu%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%RPIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Seni%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disc%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Reve%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Valu%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the CIO - Department of Education%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 10) LIKE '%Central - %' THEN 'Department of Education'
		WHEN responsibleagency LIKE '%Alternative Superintendency%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 9) LIKE '%School - %' THEN 'Department of Education'
		WHEN (RIGHT(responsibleagency, 2) !~* '^[A-Z]+$') AND responsibleagency NOT LIKE '%3-1-1%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 3) LIKE '%BCC%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%A - %' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%P - %' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Lot Cleaning%' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Fire Department Operations Center%' THEN 'Fire Department of New York'
		WHEN LEFT(responsibleagency, 4) LIKE '%Link%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 4) LIKE '%Traf%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 4) LIKE '%Inve%' THEN 'New York City Police Department' 
		WHEN responsibleagency LIKE '%Correspondence - Taxi and Limousine Commission%' THEN 'Taxi and Limousine Commission'
		WHEN responsibleagency LIKE '%3-1-1%' THEN '3-1-1 Call Center'
		WHEN responsibleagency LIKE '%NYCEM Property Damage%' THEN 'NYC Emergency Management'
		
		--Write out any abbreviated agency names
		WHEN LEFT(responsibleagency, 3) LIKE '%ACS%' THEN 'Administration for Children''s services'
		WHEN LEFT(responsibleagency, 3) LIKE '%CEO%' THEN 'Center for Employment'
		WHEN LEFT(responsibleagency, 4) LIKE '%DFTA%' THEN 'Department for the Aging'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOB%' THEN 'Department of Buildings'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOE%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOF%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%DRIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 5) LIKE '%DoITT%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOT%' THEN 'Department of Transportation'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCA%' THEN 'Department of Consumer Affairs'
		WHEN LEFT(responsibleagency, 3) LIKE '%DPR%' THEN 'Department of Parks and Recreation'
		WHEN LEFT(responsibleagency, 4) LIKE '%COIB%' THEN 'Conflice of Interest Board'
		WHEN LEFT(responsibleagency, 4) LIKE '%DCAS%' THEN 'Department of Citywide Adminstrative Services'
		WHEN LEFT(responsibleagency, 5) LIKE '%DOHMH%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCP%' THEN 'Department of City Planning'
		WHEN LEFT(responsibleagency, 4) LIKE '%NYPD%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 3) LIKE '%DVS%' THEN 'Department of Verteran''s Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%MOC%' THEN 'Mayor''s Office of Contract Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%OMB%' THEN 'Office of the Mayoral Budget'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAX%' THEN 'New York City Tax Commission'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAT%' THEN 'Tourism Authority of Thailand'
		WHEN LEFT(responsibleagency, 3) LIKE '%TLC%' THEN 'Taxi and Limousine Commission'
		
		ELSE responsibleagency 
	END AS responsibleagency,
	'2017' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		--Use 0 when average time to close negative
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN 0
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case request types
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case categories
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
				
			
FROM public.nyc_311_2017
GROUP BY 1, 2

UNION
--2016--
SELECT
	DISTINCT(agency_code),
	CASE 
		--Consolidate different sub agencies into a single count for an agency
		WHEN responsibleagency LIKE '%HealthCare Connections%' THEN 'Department for the Aging'
		WHEN responsibleagency LIKE '%Operations Unit - Department of Homeless Services%' THEN 'Department of Homeless Services'
		WHEN LEFT(responsibleagency, 4) LIKE '%Mosq%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Chil%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 4) LIKE '%Adju%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Comm%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Cond%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disa%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Exte%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Land%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Correspondence Unit%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Sheriff' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Dunn%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the Taxpayer Advocate%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Paym%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Pers%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Prop%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Refu%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%RPIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Seni%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Disc%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Reve%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%Valu%' THEN 'Department of Finance'
		WHEN responsibleagency LIKE '%Office of the CIO - Department of Education%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 10) LIKE '%Central - %' THEN 'Department of Education'
		WHEN responsibleagency LIKE '%Alternative Superintendency%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 9) LIKE '%School - %' THEN 'Department of Education'
		WHEN (RIGHT(responsibleagency, 2) !~* '^[A-Z]+$') AND responsibleagency NOT LIKE '%3-1-1%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 3) LIKE '%BCC%' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%A - %' THEN 'Department of Sanitation'
		WHEN LEFT(responsibleagency, 4) LIKE '%P - %' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Lot Cleaning%' THEN 'Department of Sanitation'
		WHEN responsibleagency LIKE '%Fire Department Operations Center%' THEN 'Fire Department of New York'
		WHEN LEFT(responsibleagency, 4) LIKE '%Link%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 4) LIKE '%Traf%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 4) LIKE '%Inve%' THEN 'New York City Police Department' 
		WHEN responsibleagency LIKE '%Correspondence - Taxi and Limousine Commission%' THEN 'Taxi and Limousine Commission'
		WHEN responsibleagency LIKE '%3-1-1%' THEN '3-1-1 Call Center'
		WHEN responsibleagency LIKE '%NYCEM Property Damage%' THEN 'NYC Emergency Management'
		
		--Write out any abbreviated agency names
		WHEN LEFT(responsibleagency, 3) LIKE '%ACS%' THEN 'Administration for Children''s services'
		WHEN LEFT(responsibleagency, 3) LIKE '%CEO%' THEN 'Center for Employment'
		WHEN LEFT(responsibleagency, 4) LIKE '%DFTA%' THEN 'Department for the Aging'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOB%' THEN 'Department of Buildings'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOE%' THEN 'Department of Education'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOF%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 4) LIKE '%DRIE%' THEN 'Department of Finance'
		WHEN LEFT(responsibleagency, 5) LIKE '%DoITT%' THEN 'Department of Information Technology and Telecommunications'
		WHEN LEFT(responsibleagency, 3) LIKE '%DOT%' THEN 'Department of Transportation'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCA%' THEN 'Department of Consumer Affairs'
		WHEN LEFT(responsibleagency, 3) LIKE '%DPR%' THEN 'Department of Parks and Recreation'
		WHEN LEFT(responsibleagency, 4) LIKE '%COIB%' THEN 'Conflice of Interest Board'
		WHEN LEFT(responsibleagency, 4) LIKE '%DCAS%' THEN 'Department of Citywide Adminstrative Services'
		WHEN LEFT(responsibleagency, 5) LIKE '%DOHMH%' THEN 'Department of Health and Mental Hygiene'
		WHEN LEFT(responsibleagency, 3) LIKE '%DCP%' THEN 'Department of City Planning'
		WHEN LEFT(responsibleagency, 4) LIKE '%NYPD%' THEN 'New York City Police Department'
		WHEN LEFT(responsibleagency, 3) LIKE '%DVS%' THEN 'Department of Verteran''s Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%MOC%' THEN 'Mayor''s Office of Contract Services'
		WHEN LEFT(responsibleagency, 3) LIKE '%OMB%' THEN 'Office of the Mayoral Budget'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAX%' THEN 'New York City Tax Commission'
		WHEN LEFT(responsibleagency, 3) LIKE '%TAT%' THEN 'Tourism Authority of Thailand'
		WHEN LEFT(responsibleagency, 3) LIKE '%TLC%' THEN 'Taxi and Limousine Commission'
		
		ELSE responsibleagency 
	END AS responsibleagency,
	'2016' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		--Use 0 when average time to close negative
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN 0
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case request types
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lower all upper case categories
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
				
			
FROM public.nyc_311_2016
GROUP BY 1, 2
--Order by Year chronologically
ORDER BY Year
;
-----------------------------------------------------------------------------------------------------------------
--Borough--
-----------------------------------------------------------------------------------------------------------------
--Request count by city borough with average and median time to close, most common request type and category
SELECT
	DISTINCT(
		CASE 
			--Consolidate unspecified communityboardids into one count per borough
			WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
			WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
			WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
			WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
			WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
			WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		 	WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END) AS Borough,	
	'2020' AS Year,
	COUNT(request_id),
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS Median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of requesttype
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category
	
FROM public.nyc_311_2020
GROUP BY 1

UNION
--2019--
SELECT
	DISTINCT(
		CASE 
			--Consolidate unspecified communityboardids into one count per borough
			WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
			WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
			WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
			WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
			WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
			WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		 	WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END) AS Borough,	
	'2019' AS Year,
	COUNT(request_id),
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS Median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of requesttype
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category
	
FROM public.nyc_311_2019
GROUP BY 1

UNION
--2018--
SELECT
	DISTINCT(
		CASE 
			--Consolidate unspecified communityboardids into one count per borough
			WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
			WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
			WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
			WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
			WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
			WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		 	WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END) AS Borough,	
	'2018' AS Year,
	COUNT(request_id),
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS Median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of requesttype
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category
	
FROM public.nyc_311_2018
GROUP BY 1

UNION

--2017--
SELECT
	DISTINCT(
		CASE 
			--Consolidate unspecified communityboardids into one count per borough
			WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
			WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
			WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
			WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
			WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
			WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		 	WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END) AS Borough,	
	'2017' AS Year,
	COUNT(request_id),
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS Median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of requesttype
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category
	
FROM public.nyc_311_2017
GROUP BY 1

UNION
--2016--
SELECT
	DISTINCT(
		CASE 
			--Consolidate unspecified communityboardids into one count per borough
			WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
			WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
			WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
			WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
			WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
			WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		 	WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END) AS Borough,	
	'2016' AS Year,
	COUNT(request_id),
	ROUND(AVG(closed_date::date - created_date::date), 2) AS avg_time_to_close,
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) AS Median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of requesttype
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Lowercase all but first letter of category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category
	
FROM public.nyc_311_2016
GROUP BY 1
--Order by Year Chronologically
ORDER BY Year
;
-----------------------------------------------------------------------------------------------------------------
--Zip_Code--
-----------------------------------------------------------------------------------------------------------------
--Request Count by 5 Digit Zip Code and borough, avg and median time to close
--NOT USED IN ANALYSIS: Most common request type and category and most common month, day and hour of request
--2020--
SELECT
	DISTINCT(
		CASE 
			--Add to unspecified if 5 digit zip not included
			WHEN RIGHT(address, 5) !~ '^[0-9]+$' THEN 'Unspecified'
			--Add to unspecified if 5 digit zip null
			WHEN RIGHT(address, 5) IS NULL THEN 'Unspecified'
			ELSE RIGHT(address, 5)
		END) AS zip_code,
	CASE 
		--Consolidate unspecified communityboardid into borough
		WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
		WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
		WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
		WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
		WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
		WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END AS Borough,
	'2020' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common request type 
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day and hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
FROM public.nyc_311_2020
GROUP BY 1, 2

UNION
--2019--
SELECT
	DISTINCT(
		CASE 
			--Add to unspecified if 5 digit zip not included
			WHEN RIGHT(address, 5) !~ '^[0-9]+$' THEN 'Unspecified'
			--Add to unspecified if 5 digit zip null
			WHEN RIGHT(address, 5) IS NULL THEN 'Unspecified'
			ELSE RIGHT(address, 5)
		END) AS zip_code,
	CASE 
		--Consolidate unspecified communityboardid into borough
		WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
		WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
		WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
		WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
		WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
		WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END AS Borough,
	'2019' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common request type 
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day and hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
FROM public.nyc_311_2019
GROUP BY 1, 2

UNION
--2018--
SELECT
	DISTINCT(
		CASE 
			--Add to unspecified if 5 digit zip not included
			WHEN RIGHT(address, 5) !~ '^[0-9]+$' THEN 'Unspecified'
			--Add to unspecified if 5 digit zip null
			WHEN RIGHT(address, 5) IS NULL THEN 'Unspecified'
			ELSE RIGHT(address, 5)
		END) AS zip_code,
	CASE 
		--Consolidate unspecified communityboardid into borough
		WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
		WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
		WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
		WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
		WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
		WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END AS Borough,
	'2018' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common request type 
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day and hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
FROM public.nyc_311_2018
GROUP BY 1, 2

UNION
--2017--
SELECT
	DISTINCT(
		CASE 
			--Add to unspecified if 5 digit zip not included
			WHEN RIGHT(address, 5) !~ '^[0-9]+$' THEN 'Unspecified'
			--Add to unspecified if 5 digit zip null
			WHEN RIGHT(address, 5) IS NULL THEN 'Unspecified'
			ELSE RIGHT(address, 5)
		END) AS zip_code,
	CASE 
		--Consolidate unspecified communityboardid into borough
		WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
		WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
		WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
		WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
		WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
		WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END AS Borough,
	'2017' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common request type 
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day and hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
FROM public.nyc_311_2017
GROUP BY 1, 2

UNION
--2016--
SELECT
	DISTINCT(
		CASE 
			--Add to unspecified if 5 digit zip not included
			WHEN RIGHT(address, 5) !~ '^[0-9]+$' THEN 'Unspecified'
			--Add to unspecified if 5 digit zip null
			WHEN RIGHT(address, 5) IS NULL THEN 'Unspecified'
			ELSE RIGHT(address, 5)
		END) AS zip_code,
	CASE 
		--Consolidate unspecified communityboardid into borough
		WHEN communityboardid LIKE '%Unspecified BRONX%' THEN 'Bronx'
		WHEN communityboardid LIKE '%Unspecified BROOKLYN%' THEN 'Brooklyn'
		WHEN communityboardid LIKE '%Unspecified MANHATTAN%' THEN 'Manhattan'
		WHEN communityboardid LIKE '%Unspecified QUEENS%' THEN 'Queens'
		WHEN communityboardid LIKE '%Unspecified STATEN ISLAND%' THEN 'Staten Island'
		WHEN communityboardid LIKE '%Unspecified%' THEN 'Unspecified'
		WHEN LEFT(communityboardid, 4) LIKE '%S%' THEN 'Staten Island'
		--Lowercase all but first letter of borough
		ELSE CONCAT((SUBSTRING(communityboardid, 4, 1)), LOWER(SUBSTRING(communityboardid, 5)))
		END AS Borough,
	'2016' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly average time to close if null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median time to close if null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common request type 
			 	WHEN LEFT(requesttype, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 	WHEN LEFT(requesttype, 3) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 3), LOWER(SUBSTRING(requesttype, 4)))
			 	WHEN LEFT(requesttype, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(requesttype, 1, 1), LOWER(SUBSTRING(requesttype, 2)))
			 ELSE requesttype END) AS requesttype)) AS mode_requesttype,
	MODE() WITHIN GROUP (ORDER BY (
	SELECT 
			DISTINCT
			(CASE 
				--Most common category
			 	WHEN LEFT(category, 4) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN LEFT(category, 2) ~ '^[A-Z]+$' THEN CONCAT(SUBSTRING(category, 1, 1), LOWER(SUBSTRING(category, 2)))
			 	WHEN category ILIKE '%N/A%' THEN requesttype
			 	WHEN category IS NULL THEN requesttype
			 ELSE category END) AS category)) AS mode_category,
	--Most common month, day and hour
	MODE() WITHIN GROUP (ORDER BY DATE_PART('month', created_date)) AS month_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('day', created_date)) AS day_mode,
	MODE() WITHIN GROUP (ORDER BY DATE_PART('hour', created_date)) AS hour_mode
FROM public.nyc_311_2016
GROUP BY 1, 2
--Order by zip_code numerically
ORDER BY zip_code
;
-----------------------------------------------------------------------------------------------------------------
--Source--
-----------------------------------------------------------------------------------------------------------------
--Request Count by request source (Mobile, Online, Other, Phone or Unknown), avg and median time to close

SELECT
	--Lowercase all but first letter of source
	CONCAT(SUBSTRING(source, 1, 1), LOWER(SUBSTRING(source, 2))) AS source,
	'2020' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg time to close is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median time to close is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
	
FROM public.nyc_311_2020
GROUP BY 1

UNION

SELECT
	--Lowercase all but first letter of source
	CONCAT(SUBSTRING(source, 1, 1), LOWER(SUBSTRING(source, 2))) AS source,
	'2019' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg time to close is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median time to close is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
	
FROM public.nyc_311_2019
GROUP BY 1

UNION

SELECT
	--Lowercase all but first letter of source
	CONCAT(SUBSTRING(source, 1, 1), LOWER(SUBSTRING(source, 2))) AS source,
	'2018' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg time to close is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN
		--Use yearly median when median time to close is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
	
FROM public.nyc_311_2018
GROUP BY 1

UNION

SELECT
	--Lowercase all but first letter of source
	CONCAT(SUBSTRING(source, 1, 1), LOWER(SUBSTRING(source, 2))) AS source,
	'2017' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg time to close is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median time to close is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
	
FROM public.nyc_311_2017
GROUP BY 1

UNION

SELECT
	--Lowercase all but first letter of source
	CONCAT(SUBSTRING(source, 1, 1), LOWER(SUBSTRING(source, 2))) AS source,
	'2016' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg time to close is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median time to close is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
	
FROM public.nyc_311_2016
GROUP BY 1
--Order by year chronologically and source
ORDER BY Year, source
;
-----------------------------------------------------------------------------------------------------------------
--Status--
-----------------------------------------------------------------------------------------------------------------
--Request Status, count, avg and median time to close by year
--2020--
SELECT
	DISTINCT(status),
	'2020' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		--Use yearly avg when avg < 0
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2020)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		--Use yearly median when median < 0
		WHEN PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) < 0
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2020)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2020
GROUP BY 1

UNION
--2019--
SELECT
	DISTINCT(status),
	'2019' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		--Use yearly avg when avg < 0
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2019)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)
		--Use yearly median when median < 0
		WHEN PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) < 0
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2019)	  
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2019
GROUP BY 1

UNION

--2018--
SELECT
	DISTINCT(status),
	'2018' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		--Use yearly avg when avg < 0 
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2018)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)	 
		--Use yearly median when median < 0
		WHEN PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) < 0
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2018)		
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2018
GROUP BY 1

UNION

--2017--
SELECT
	DISTINCT(status),
	'2017' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		--Use yearly avg when avg < 0 
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2017)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		--Use yearly median when median < 0
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		WHEN PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) < 0
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2017)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2017
GROUP BY 1

UNION

--2016--
SELECT
	DISTINCT(status),
	'2016' AS Year,
	COUNT(request_id),
	CASE WHEN
		--Use yearly avg when avg is null
		ROUND(AVG(closed_date::date - created_date::date), 2) IS NULL
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		--Use yearly avg when avg < 0 
		WHEN ROUND(AVG(closed_date::date - created_date::date), 2) < 0
		THEN (SELECT ROUND(AVG(closed_date::date - created_date::date), 2) FROM public.nyc_311_2016)
		WHEN PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) < 0
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE ROUND(AVG(closed_date::date - created_date::date), 2)
		END AS avg_time_to_close,
	CASE WHEN 
		--Use yearly median when median is null
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) IS NULL
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		WHEN PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) < 0
		THEN (SELECT PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date)) FROM public.nyc_311_2016)
		ELSE PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY (closed_date::date - created_date::date))
		END AS median_time_to_close
FROM public.nyc_311_2016
GROUP BY 1
--Order by avg time to close
ORDER BY avg_time_to_close
;


