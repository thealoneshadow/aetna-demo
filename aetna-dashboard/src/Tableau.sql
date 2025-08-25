function filterLatestYearObjects(arr) {
  // Extract years where available
  const years = arr
    .map(obj => parseInt(obj.path?.[0]))
    .filter(year => !isNaN(year));

  // Find the latest year (if any)
  const latestYear = years.length ? Math.max(...years) : null;

  return arr.filter(obj => {
    if (!obj.path || obj.path.length === 0) {
      return true; // keep if path empty
    }

    const year = parseInt(obj.path[0]);
    if (isNaN(year)) {
      return true; // keep if first element is not a year
    }

    return year === latestYear; // keep only latest year
  });
}
