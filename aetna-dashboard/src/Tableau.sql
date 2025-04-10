import React, { useState } from "react";
import { FaThumbsUp, FaThumbsDown } from "react-icons/fa";

const ChatApp = () => {
  const [messages, setMessages] = useState([
    { id: 1, text: "Hello! How can I help you?", feedback: null },
    { id: 2, text: "Sure, I can explain that!", feedback: null },
  ]);

  const handleFeedback = (id, feedbackType) => {
    setMessages((prevMessages) =>
      prevMessages.map((msg) =>
        msg.id === id ? { ...msg, feedback: feedbackType } : msg
      )
    );
  };

  return (
    <div className="chat-container" style={{ maxWidth: "600px", margin: "auto" }}>
      {messages.map((msg) => (
        <div key={msg.id} style={{ padding: "10px", borderBottom: "1px solid #ddd" }}>
          <p>{msg.text}</p>

          {/* Feedback Section */}
         {msg.feedback ? (
            <p style={{ color: "green", fontWeight: "bold" }}>Thank you for your feedback!</p>
          ) : (
            <div style={{ marginTop: "5px" }}>
              <p style={{ fontSize: "14px", marginBottom: "5px" }}>
                Was this response helpful?
              </p>
              <button
                onClick={() => handleFeedback(msg.id, "Yes")}
                style={{
                  padding: "5px 10px",
                  marginRight: "10px",
                  border: "1px solid #ccc",
                  cursor: "pointer",
                  backgroundColor: "#f0f0f0",
                }}
              >
                Yes
              </button>
              <button
                onClick={() => handleFeedback(msg.id, "No")}
                style={{
                  padding: "5px 10px",
                  border: "1px solid #ccc",
                  cursor: "pointer",
                  backgroundColor: "#f0f0f0",
                }}
              >
                No
              </button>
            </div>
          )}
      ))}
    </div>
  );
};

export default ChatApp;


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


