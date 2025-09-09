WITH distinct_verticals AS (
    SELECT
        userId,
        ARRAY_AGG(JSON_VALUE(value, "$.vertical")) AS verticals_array
    FROM (
        SELECT DISTINCT userId, JSON_VALUE(value, "$.vertical") AS vertical
        FROM user_feedback
        WHERE
            (@startDate IS NULL OR createdAt >= @startDate)
            AND (@endDate IS NULL OR createdAt <= @endDate)
            AND (@vertical IS NULL OR JSON_VALUE(value, "$.vertical") = @vertical)
    )
    GROUP BY userId
)

SELECT
    uf.userId,
    ARRAY_TO_STRING(dv.verticals_array, ", ") AS verticals,
    COUNT(*) AS total_responses,
    COUNT(IF(JSON_VALUE(uf.value, "$.isSQLQuery") = "true", 1, NULL)) AS total_sql_queries,
    COUNT(IF(uf.feedback IS NOT NULL AND uf.feedback != "", 1, NULL)) AS total_feedbacks,
    AVG(CAST(JSON_VALUE(uf.value, "$.time") AS INT64)) AS avg_response_time
FROM
    user_feedback uf
LEFT JOIN
    distinct_verticals dv ON uf.userId = dv.userId
WHERE
    (@startDate IS NULL OR uf.createdAt >= @startDate)
    AND (@endDate IS NULL OR uf.createdAt <= @endDate)
    AND (@vertical IS NULL OR JSON_VALUE(uf.value, "$.vertical") = @vertical)
GROUP BY
    uf.userId, dv.verticals_array
ORDER BY
    total_responses DESC;
