const nameCountMap = new Map();

// Loop through the data array
for (const item of data) {
  const { name, count, vertical } = item;
  if (nameCountMap.has(name)) {
    // If the name already exists in the Map, update the count
    nameCountMap.get(name).count += count;
  } else {
    // If the name does not exist in the Map, add a new entry
    nameCountMap.set(name, { name, count, vertical });
  }
}

// Convert the Map back to an array of objects
const uniqueData = Array.from(nameCountMap.values());


INSERT INTO userList (userId, userName, email)
SELECT 'new_user_id', 'New User', 'new.user@example.com'
WHERE NOT EXISTS (
    SELECT 1
    FROM userList
    WHERE email = 'new.user@example.com'
);