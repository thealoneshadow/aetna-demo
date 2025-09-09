SELECT
    userId,
    STRING_AGG(DISTINCT value->>'vertical', ', ') AS verticals,
    COUNT(*) AS total_responses,
    COUNT(CASE WHEN (value->>'isSQLQuery')::BOOLEAN = true THEN 1 END) AS total_sql_queries,
    COUNT(CASE WHEN feedback IS NOT NULL AND feedback <> '' THEN 1 END) AS total_feedbacks,
    AVG((value->>'time')::INT) AS avg_response_time
FROM
    user_feedback
WHERE
    (:startDate IS NULL OR createdAt >= :startDate)
    AND (:endDate IS NULL OR createdAt <= :endDate)
    AND (:vertical IS NULL OR value->>'vertical' = :vertical)
GROUP BY
    userId
ORDER BY
    total_responses DESC;
