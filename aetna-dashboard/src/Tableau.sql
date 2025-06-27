const getColumnSearchAndFilterProps = (dataIndex, dataSource) => {
  // 1. Get unique values from data
  const uniqueValues = Array.from(
    new Set(dataSource.map(row => row[dataIndex]))
  ).filter(v => v !== undefined && v !== null);

  return {
    filters: uniqueValues.map(value => ({
      text: String(value),
      value: value,
    })),
    onFilter: (value, record) => String(record[dataIndex]) === String(value),
    filterSearch: true, // allows search within filter dropdown
    // Optional: column search box can be added below
    render: (text) => text,
  };
};


const newColumns = columns.map(item => ({
  ...item,
  ...getColumnSearchAndFilterProps(item.dataIndex, data), // ⬅️ here
  hidden: !checkedList.includes(item.key),
}));
