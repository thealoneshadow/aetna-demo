const newColumns = columns.map((item) => {
  const withSearch = {
    ...item,
    ...getSearchProps(item.dataIndex), // Add search functionality
    hidden: !checkedList.includes(item.key), // Control visibility
  };
  return withSearch;
});


const newColumns = columns.map((item) => ({
  ...item,
  ...getSearchProps(item.dataIndex),
  hidden: !checkedList.includes(item.key),
}));
