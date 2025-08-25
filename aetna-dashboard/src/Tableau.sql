function filterLatestByYear(objects) {
  const map = new Map();

  for (const obj of objects) {
    const [year, dashboard] = obj.path;

    // if year is a number (string) and dashboard exists
    if (year && dashboard && !isNaN(year)) {
      const existing = map.get(dashboard);

      if (!existing || parseInt(year) > parseInt(existing.path[0])) {
        map.set(dashboard, obj);
      }
    } else {
      // If no valid year, store directly with unique key
      map.set(JSON.stringify(obj.path), obj);
    }
  }

  return Array.from(map.values());
}

// Example
const data = [
  { id: 1, path: ["2023", "MMPd"] },
  { id: 2, path: ["2024", "MMPd"] },
  { id: 3, path: ["", "OtherDashboard"] },
  { id: 4, path: ["2022", "Sales"] },
  { id: 5, path: ["2021", "Sales"] },
];

console.log(filterLatestByYear(data));
