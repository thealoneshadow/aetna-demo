INSERT INTO userList (userName, email)
SELECT newUsers.userName, newUsers.email
FROM (VALUES
    ('John Doe', 'john.doe@example.com'),
    ('Jane Smith', 'jane.smith@example.com'),
    ('Alice Johnson', 'alice.johnson@example.com')
) AS newUsers(userName, email)
LEFT JOIN userList ON newUsers.email = userList.email
WHERE userList.email IS NULL;