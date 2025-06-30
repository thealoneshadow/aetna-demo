import React, { useState, useEffect, useMemo } from 'react';

const MyTable = () => {
  const [data, setData] = useState([]);
  const [checkedList, setCheckedList] = useState(['name', 'age']); // example
  const columns = [
    { title: 'Name', dataIndex: 'name', key: '0' },
    { title: 'Age', dataIndex: 'age', key: '1' },
    { title: 'Address', dataIndex: 'address', key: '2' },
  ];

  const getColumnSearchAndFilterProps = (dataIndex) => {
    const uniqueValues = Array.from(new Set(data.map(d => d[dataIndex])));

    return {
      filters: uniqueValues.map(v => ({ text: v, value: v })),
      onFilter: (value, record) => record[dataIndex] === value,
    };
  };

  // ✅ useMemo must be called inside a React component, not inside map
  const newColumns = useMemo(() => {
    return columns.map(item => ({
      ...item,
      ...getColumnSearchAndFilterProps(item.dataIndex),
      hidden: !checkedList.includes(item.dataIndex),
    }));
  }, [columns, checkedList, data]);

  return (
    <Table
      dataSource={data}
      columns={newColumns.filter(col => !col.hidden)}
      rowKey="key"
    />
  );
};
