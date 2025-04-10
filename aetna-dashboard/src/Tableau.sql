function isGreeting(message) {
  const regex = /\b(hi|hello|hey|how are you|what'?s up|yo|good (morning|evening|afternoon))\b/i;
  return regex.test(message.trim());
}

function generateTitle(message) {
  if (isGreeting(message)) return "New Chat";

  return message
    .trim()
    .split(" ")
    .slice(0, 5)
    .map(word => word[0].toUpperCase() + word.slice(1))
    .join(" ");
}




  {"question": "cool", "answer": "I'm not sure what information you're looking for with the word "cool". Can you please rephrase your query or tell me what you'd like to know?", "decision": "[Clarify]", "explanation": "The user query "cool" is vague and doesn't provide any context.  Clarification is needed to understand the user's intent.", "logId": "05bcf825-7b63-47b1-9816-36b80b6047df"}


-----------------------------



// ExportExcel.tsx
import React from "react";
import * as XLSX from "xlsx";

const ExportExcel = () => {
  const fetchDataAndExport = async () => {
    try {
      const response = await fetch("https://your-api-url.com/data");
      const data: string[][] = await response.json(); // array of arrays of strings

      const worksheet = XLSX.utils.aoa_to_sheet(data);
      const workbook = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");

      // Trigger download directly
      XLSX.writeFile(workbook, "data.xlsx");
    } catch (error) {
      console.error("Error generating Excel file:", error);
    }
  };

  return (
    <button
      onClick={fetchDataAndExport}
      className="bg-green-600 text-white px-4 py-2 rounded"
    >
      Download Excel
    </button>
  );
};

export default ExportExcel;


