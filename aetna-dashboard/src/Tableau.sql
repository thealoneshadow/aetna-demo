function areArraysEqual(arr1, arr2) {
  if (arr1.length !== arr2.length) return false;

  const stringify = obj => JSON.stringify(obj);
  const set1 = new Set(arr1.map(stringify));
  const set2 = new Set(arr2.map(stringify));

  for (let item of set1) {
    if (!set2.has(item)) return false;
  }
  return true;
}
