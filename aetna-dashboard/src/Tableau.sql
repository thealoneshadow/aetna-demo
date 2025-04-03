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
