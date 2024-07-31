// ExcelUploader.js

import React, { useState } from 'react';
import XLSX from 'xlsx';

const ExcelUploader = () => {
  const [data, setData] = useState([]);

  const handleFileUpload = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    try {
      const reader = new FileReader();
      reader.onload = (event) => {
        const binaryData = event.target.result;
        const workbook = XLSX.read(binaryData, { type: 'binary' });
        const sheetName = workbook.SheetNames[0];
        const sheet = workbook.Sheets[sheetName];

        // Assuming columns 3 and 4 (indexed from 0) contain email and team data
        const rows = XLSX.utils.sheet_to_json(sheet, { header: 1 });
        const extractedData = rows.map((row) => ({
          email: row[2], // Column 3
          team: row[3], // Column 4
        }));

        setData(extractedData);
      };
      reader.readAsBinaryString(file);
    } catch (error) {
      console.error('Error reading Excel file:', error);
    }
  };

  return (
    <div>
      <input type="file" accept=".xls,.xlsx" onChange={handleFileUpload} />
      {data.length > 0 && (
        <pre>{JSON.stringify(data, null, 2)}</pre>
      )}
    </div>
  );
};

export default ExcelUploader;
