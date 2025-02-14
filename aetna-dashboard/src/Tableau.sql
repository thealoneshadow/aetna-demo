import React, { useState } from "react";
import * as Papa from "papaparse";

const CSVUploader = () => {
  const [parsedData, setParsedData] = useState([]);

  const handleFileUpload = (event) => {
    const files = event.target.files;
    const fileDataArray = [];

    Array.from(files).forEach((file) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        const csvData = e.target.result;
        Papa.parse(csvData, {
          complete: (result) => {
            if (result.data.length > 1) {
              const headers = result.data[0];
              const dataRows = result.data.slice(1);

              const structuredData = dataRows.map((row) => ({
                name: row[headers.indexOf("column_name")],
                type: row[headers.indexOf("data_type")],
                is_nullable: row[headers.indexOf("is_nullable")],
                is_partitioning: row[headers.indexOf("is_partioning")],
                default: row[headers.indexOf("default")],
                description: ""
              }));

              fileDataArray.push({ fileName: file.name, data: structuredData });
              setParsedData((prev) => [...prev, { fileName: file.name, data: structuredData }]);
              saveAsJson([...parsedData, { fileName: file.name, data: structuredData }]);
            }
          },
          header: false,
          skipEmptyLines: true
        });
      };
      reader.readAsText(file);
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
      <input type="file" multiple accept=".csv" onChange={handleFileUpload} />
      <div className="mt-4">
        {parsedData.map((file, fileIndex) => (
          <div key={fileIndex} className="border p-2 mb-4">
            <h3 className="font-bold">{file.fileName}</h3>
            <ul>
              {file.data.map((col, index) => (
                <li key={index}>
                  {col.name} - {col.type} - {col.is_nullable} - {col.is_partitioning} - {col.default} - {col.description}
                </li>
              ))}
            </ul>
          </div>
        ))}
      </div>
    </div>
  );
};
export default CSVUploader;
