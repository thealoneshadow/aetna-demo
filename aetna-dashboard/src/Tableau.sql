const getColumnSearchAndFilterProps = (dataIndex) => {
  const uniqueValues = Array.from(new Set(data.map(d => d[dataIndex]))).filter(v => v != null);

  return {
    filters: uniqueValues.map(v => ({ text: String(v), value: v })),
    onFilter: (value, record) => String(record[dataIndex]) === String(value),
    filterSearch: true,

    // ✅ Add sorter
    sorter: (a, b) => {
      const aVal = a[dataIndex];
      const bVal = b[dataIndex];

      // If both are numbers, sort numerically
      if (!isNaN(aVal) && !isNaN(bVal)) return aVal - bVal;

      // Else, sort lexically
      return String(aVal).localeCompare(String(bVal));
    },

    // Optional: default sort order
    // sortOrder: 'ascend', // or 'descend'

    // Optional extras
    ellipsis: true,
    align: 'left',
  };
};
