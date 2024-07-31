Certainly! Let’s create a React component that allows users to upload an Excel file and then extracts columns 3 and 4 (assuming the columns are indexed from 0) to create a JSON array of objects with the specified keys (email and team).

Here’s how you can achieve this:

Install Dependencies: First, install the necessary dependencies for handling file uploads and parsing Excel files:
npm install xlsx-file-reader
# or
yarn add xlsx-file-reader

Create the File Upload Component: Create a new component (let’s call it ExcelUploader) that allows users to upload an Excel file. When the file is uploaded, we’ll read its contents and extract the required columns.
// ExcelUploader.js

import React, { useState } from 'react';
import XLSX from 'xlsx-file-reader';

const ExcelUploader = () => {
  const [data, setData] = useState([]);

  const handleFileUpload = async (e) => {
    const file = e.target.files[0];
    if (!file) return;

    try {
      const workbook = await XLSX.readFile(file);
      const sheetName = workbook.SheetNames[0];
      const sheet = workbook.Sheets[sheetName];

      // Assuming columns 3 and 4 (indexed from 0) contain email and team data
      const rows = XLSX.utils.sheet_to_json(sheet, { header: 1 });
      const extractedData = rows.map((row) => ({
        email: row[2], // Column 3
        team: row[3], // Column 4
      }));

      setData(extractedData);
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