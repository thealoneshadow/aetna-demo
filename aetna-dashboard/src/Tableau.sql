function getRandomItemsPerVertical(data, count = 2) {
  const grouped = {};

  // Step 1: Group by 'vertical'
  for (const item of data) {
    const key = item.vertical;
    if (!grouped[key]) grouped[key] = [];
    grouped[key].push(item);
  }

  // Step 2: Pick random items
  const result = [];
  for (const key in grouped) {
    const items = grouped[key];

    // Shuffle items
    const shuffled = [...items].sort(() => Math.random() - 0.5);

    // Pick 'count' items (or fewer if not enough)
    result.push(...shuffled.slice(0, count));
  }

  return result;
}

// ✅ Usage
const selected = getRandomItemsPerVertical(data);
console.log(selected);
