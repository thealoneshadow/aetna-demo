function filterLatestByYear(objects) {
  const grouped = {};

  for (const obj of objects) {
    const path = obj.path || [];

    // Rule 3: keep empty paths as-is
    if (path.length === 0) {
      if (!grouped["__empty__"]) grouped["__empty__"] = [];
      grouped["__empty__"].push(obj);
      continue;
    }

    const [year, dashboard] = path;

    // If year is valid
    if (year && !isNaN(year) && dashboard) {
      if (!grouped[dashboard]) grouped[dashboard] = [];
      grouped[dashboard].push(obj);
    } else {
      // If year missing or not valid, just store with unique key
      const key = JSON.stringify(path);
      if (!grouped[key]) grouped[key] = [];
      grouped[key].push(obj);
    }
  }

  const result = [];

  for (const key in grouped) {
    if (key === "__empty__") {
      result.push(...grouped[key]); // keep all empty path objects
      continue;
    }

    // find latest year among objects of this dashboard
    const objs = grouped[key];
    const maxYear = Math.max(
      ...objs.map(o => parseInt(o.path[0])).filter(y => !isNaN(y))
    );

    // keep only objects with the latest year
    result.push(...objs.filter(o => parseInt(o.path[0]) === maxYear));
  }

  return result;
}
