INSERT INTO userList (userName, email)
SELECT newUsers.userName, newUsers.email
FROM (VALUES
    ('John Doe', 'john.doe@example.com'),
    ('Jane Smith', 'jane.smith@example.com'),
    ('Alice Johnson', 'alice.johnson@example.com')
) AS newUsers(userName, email)
LEFT JOIN userList ON newUsers.email = userList.email
WHERE userList.email IS NULL;


INSERT INTO userList (userId, userName, email)
SELECT 'new_user_id', 'New User', 'new.user@example.com'
WHERE NOT EXISTS (
    SELECT 1
    FROM userList
    WHERE email = 'new.user@example.com'
);