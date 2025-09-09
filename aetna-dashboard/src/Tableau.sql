SELECT
    userId,
    ARRAY_TO_STRING(ARRAY(SELECT DISTINCT JSON_VALUE(value, "$.vertical")), ", ") AS verticals,
    COUNT(*) AS total_responses,
    COUNT(IF(JSON_VALUE(value, "$.isSQLQuery") = "true", 1, NULL)) AS total_sql_queries,
    COUNT(IF(feedback IS NOT NULL AND feedback != "", 1, NULL)) AS total_feedbacks,
    AVG(CAST(JSON_VALUE(value, "$.time") AS INT64)) AS avg_response_time
FROM
    user_feedback
WHERE
    (@startDate IS NULL OR createdAt >= @startDate)
    AND (@endDate IS NULL OR createdAt <= @endDate)
    AND (@vertical IS NULL OR JSON_VALUE(value, "$.vertical") = @vertical)
GROUP BY
    userId
ORDER BY
    total_responses DESC;
