import React, { useState } from "react";
import * as XLSX from "xlsx";

export default function ExcelUploader() {
  const [data, setData] = useState([]);

  const handleFileUpload = (e) => {
    const file = e.target.files[0];

    if (!file) return;

    const reader = new FileReader();

    reader.onload = (evt) => {
      const binaryStr = evt.target.result;
      const workbook = XLSX.read(binaryStr, { type: "binary" });

      // Get first worksheet
      const sheetName = workbook.SheetNames[0];
      const worksheet = workbook.Sheets[sheetName];

      // Convert to JSON
      const jsonData = XLSX.utils.sheet_to_json(worksheet);

      // Extract question and query columns
      const formattedData = jsonData.map((row) => ({
        question: row.question || row.Question || "", // case-insensitive fallback
        query: row.query || row.Query || "",
      }));

      setData(formattedData);
      console.log("Formatted Data:", formattedData);
    };

    reader.readAsBinaryString(file);
  };

  return (
    <div className="p-4">
      <input
        type="file"
        accept=".xlsx, .xls"
        onChange={handleFileUpload}
        className="mb-4"
      />

      {data.length > 0 && (
        <ul>
          {data.map((item, idx) => (
            <li key={idx} className="mb-2">
              <strong>Q:</strong> {item.question} <br />
              <strong>Query:</strong> {item.query}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
