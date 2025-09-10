SELECT 
  userId,
  ARRAY_AGG(DISTINCT JSON_VALUE(value_json, '$.vertical')) AS verticals,
  COUNT(*) AS total_responses,
  COUNTIF(JSON_VALUE(value_json, '$.isSQLQuery') = 'true') AS total_sql_responses,
  COUNTIF(feedback != '') AS total_feedbacks,
  SUM(CAST(JSON_VALUE(value_json, '$.time') AS INT64)) AS total_response_time
FROM 
  user_feedback
WHERE 
  date BETWEEN @start_date AND @end_date
  AND (@vertical IS NULL OR JSON_VALUE(value_json, '$.vertical') = @vertical)
GROUP BY 
  userId
ORDER BY 
  total_responses DESC;

SELECT 
  userId,
  ARRAY_AGG(DISTINCT JSON_VALUE(value_json, '$.vertical')) AS verticals,
  COUNT(*) AS total_responses,
  COUNTIF(JSON_VALUE(value_json, '$.isSQLQuery') = 'true') AS total_sql_responses,
  COUNTIF(feedback != '') AS total_feedbacks,
  SUM(CAST(JSON_VALUE(value_json, '$.time') AS INT64)) AS total_response_time
FROM 
  user_feedback
WHERE 
  date BETWEEN @start_date AND @end_date
  AND (@vertical IS NULL OR JSON_VALUE(value_json, '$.vertical') = @vertical)
  AND value_json IS NOT NULL
  AND TRIM(value_json) != ''
GROUP BY 
  userId
ORDER BY 
  total_responses DESC;
