import React, { useState } from "react";
import * as XLSX from "xlsx";

const ExcelUploader = () => {
  const [parsedData, setParsedData] = useState([]);

  const handleFileUpload = (event) => {
    const files = event.target.files;
    const fileDataArray = [];

    Array.from(files).forEach((file) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const data = new Uint8Array(e.target.result);
        const workbook = XLSX.read(data, { type: "array" });
        
        workbook.SheetNames.forEach((sheetName) => {
          const sheet = workbook.Sheets[sheetName];
          const jsonData = XLSX.utils.sheet_to_json(sheet, { header: 1 });

          if (jsonData.length > 0) {
            const headers = jsonData[0];
            const types = inferColumnTypes(jsonData);

            const structuredData = headers.map((header, index) => ({
              name: header,
              type: types[index] || "Unknown",
            }));

            fileDataArray.push({ fileName: file.name, sheetName, data: structuredData });
          }
        });
        setParsedData((prev) => [...prev, ...fileDataArray]);
        saveAsJson([...fileDataArray]);
      };
      reader.readAsArrayBuffer(file);
    });
  };

  const inferColumnTypes = (data) => {
    if (data.length < 2) return [];
    return data[1].map((value) => {
      if (typeof value === "number") return "Number";
      if (typeof value === "boolean") return "Boolean";
      if (typeof value === "string" && !isNaN(Date.parse(value))) return "Date";
      return "String";
    });
  };

  const saveAsJson = (data) => {
    const jsonBlob = new Blob([JSON.stringify(data, null, 2)], { type: "application/json" });
    const link = document.createElement("a");
    link.href = URL.createObjectURL(jsonBlob);
    link.download = "parsedData.json";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="p-4">
      <input type="file" multiple accept=".xlsx, .xls" onChange={handleFileUpload} />
      <div className="mt-4">
        {parsedData.map((file, fileIndex) => (
          <div key={fileIndex} className="border p-2 mb-4">
            <h3 className="font-bold">{file.fileName} - {file.sheetName}</h3>
            <ul>
              {file.data.map((col, index) => (
                <li key={index}>{col.name} - {col.type}</li>
              ))}
            </ul>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ExcelUploader;
