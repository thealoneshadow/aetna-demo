import React, { useState, useEffect } from 'react';
import { Table } from 'antd';

const MyTable = () => {
  const [data, setData] = useState([
    { key: '1', name: 'John', age: 30, address: 'NY' },
    { key: '2', name: 'Jane', age: 25, address: 'London' },
    { key: '3', name: 'Jake', age: 30, address: 'NY' },
  ]);

  const [checkedList, setCheckedList] = useState(['name', 'age']);
  const [newColumns, setNewColumns] = useState([]);

  const columns = [
    { title: 'Name', dataIndex: 'name', key: '0' },
    { title: 'Age', dataIndex: 'age', key: '1' },
    { title: 'Address', dataIndex: 'address', key: '2' },
  ];

  const getColumnSearchAndFilterProps = (dataIndex) => {
    const uniqueValues = Array.from(
      new Set(data.map((d) => d[dataIndex]))
    ).filter(v => v !== undefined && v !== null);

    return {
      filters: uniqueValues.map((v) => ({ text: String(v), value: v })),
      onFilter: (value, record) =>
        String(record[dataIndex]) === String(value),
      filterSearch: true,
      render: (text) => text,
    };
  };

  // 🧠 useEffect to build newColumns only when data is ready
  useEffect(() => {
    if (!data.length) return;

    const updatedColumns = columns.map((item) => ({
      ...item,
      ...getColumnSearchAndFilterProps(item.dataIndex),
      hidden: !checkedList.includes(item.dataIndex),
    }));

    setNewColumns(updatedColumns);
  }, [data, checkedList]);

  return (
    <>
      {newColumns.length > 0 ? (
        <Table
          dataSource={data}
          columns={newColumns.filter((col) => !col.hidden)}
          rowKey="key"
        />
      ) : (
        <div>Loading table...</div>
      )}
    </>
  );
};

export default MyTable;
