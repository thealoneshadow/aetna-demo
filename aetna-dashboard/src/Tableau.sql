SELECT 
  id,
  name,
  userid,
  created_at,
  CASE 
    WHEN DATE(created_at) = CURRENT_DATE() THEN 'Today'
    WHEN DATE(created_at) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) THEN 'Yesterday'
    ELSE CONCAT(CAST(DATE_DIFF(CURRENT_DATE(), DATE(created_at)) AS STRING), ' days ago')
  END AS day_label
FROM your_table
WHERE userid = @userId
  AND DATE(created_at) >= DATE_SUB(CURRENT_DATE(), INTERVAL 9 DAY)
ORDER BY created_at DESC;


