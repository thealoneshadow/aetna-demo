function getTwoPerRuleId(data) {
  const grouped = {};

  // Group by ruleId
  data.forEach(item => {
    if (!grouped[item.ruleId]) grouped[item.ruleId] = [];
    grouped[item.ruleId].push(item);
  });

  const updatedList = [];

  // For each group, pick 2 random items
  for (const ruleId in grouped) {
    const items = grouped[ruleId];

    // Shuffle
    const shuffled = items.sort(() => Math.random() - 0.5);

    // Pick 2 (or less if not enough)
    updatedList.push(...shuffled.slice(0, 2));
  }

  return updatedList;
}
