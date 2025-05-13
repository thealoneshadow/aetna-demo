const handleCopy = () => {
    const header = columns.map(col => col.title).join('\t');
    const rows = dataSource.map(row =>
      columns.map(col => row[col.dataIndex]).join('\t')
    );
    const textToCopy = [header, ...rows].join('\n');

    navigator.clipboard.writeText(textToCopy).then(() => {
      alert('Table copied to clipboard!');
    });
  };

 const handleCopy = () => {
    navigator.clipboard.writeText(code.trim());
    alert('Copied to clipboard!');
  };






import React, { useState } from 'react';
import { Table, Button, Space, message } from 'antd';
import { CopyOutlined, FileExcelOutlined } from '@ant-design/icons';
import * as XLSX from 'xlsx';

// Sample table data
const dataSource = Array.from({ length: 1000 }).map((_, i) => ({
  key: i,
  name: `User ${i + 1}`,
  age: 20 + (i % 30),
  email: `user${i + 1}@example.com`,
}));

const columns = [
  { title: 'Name', dataIndex: 'name' },
  { title: 'Age', dataIndex: 'age' },
  { title: 'Email', dataIndex: 'email' },
];

const MyTable = () => {
  const [copying, setCopying] = useState(false);
  const [exporting, setExporting] = useState(false);

  // Copy handler
  const handleCopy = async () => {
    setCopying(true);
    try {
      const header = columns.map(col => col.title).join('\t');
      const rows = dataSource.map(row =>
        columns.map(col => row[col.dataIndex]).join('\t')
      );
      const textToCopy = [header, ...rows].join('\n');

      await navigator.clipboard.writeText(textToCopy);
      message.success('Copied to clipboard!');
    } catch (err) {
      message.error('Failed to copy.');
    }
    setCopying(false);
  };

  // Export to Excel handler
  const handleExport = () => {
    setExporting(true);
    try {
      const exportData = dataSource.map(row => {
        const newRow = {};
        columns.forEach(col => {
          newRow[col.title] = row[col.dataIndex];
        });
        return newRow;
      });

      const worksheet = XLSX.utils.json_to_sheet(exportData);
      const workbook = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');
      XLSX.writeFile(workbook, 'table-data.xlsx');

      message.success('Exported to Excel!');
    } catch (err) {
      message.error('Failed to export.');
    }
    setExporting(false);
  };

  return (
    <>
      <Space style={{ marginBottom: 16 }}>
        <Button
          icon={<CopyOutlined />}
          loading={copying}
          onClick={handleCopy}
        >
          {copying ? 'Copying...' : 'Copy Table'}
        </Button>

        <Button
          icon={<FileExcelOutlined />}
          loading={exporting}
          onClick={handleExport}
        >
          {exporting ? 'Exporting...' : 'Export to Excel'}
        </Button>
      </Space>

      <Table
        dataSource={dataSource}
        columns={columns}
        pagination={{ pageSize: 20 }}
        scroll={{ y: 400 }}
      />
    </>
  );
};

export default MyTable;
