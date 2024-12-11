BEGIN TRANSACTION;

-- Check for duplicates
SELECT COUNT(*) INTO duplicate_count
FROM userviewtracking
WHERE name = 'DASHBOARD_ID'
  AND userId = 'USER_ID'
  AND createdat >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 5 SECOND);

-- Conditional insert
IF duplicate_count = 0 THEN
  INSERT INTO userviewtracking (id, vertical, name, userId, duration, createdat, updatedat)
  VALUES ('NEW_ID', 'VERTICAL_VALUE', 'DASHBOARD_ID', 'USER_ID', 'DURATION', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());
END IF;

COMMIT;


INSERT INTO userviewtracking (id, vertical, name, userId, duration, createdat, updatedat)
SELECT 'NEW_ID', 'VERTICAL_VALUE', 'DASHBOARD_ID', 'USER_ID', 'DURATION', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()
WHERE NOT EXISTS (
    SELECT 1
    FROM userviewtracking
    WHERE name = 'DASHBOARD_ID'
      AND userId = 'USER_ID'
      AND createdat >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 5 SECOND)
);
