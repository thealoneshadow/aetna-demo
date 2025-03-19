import React, { useState } from "react";
import "./GeminiUI.css";

const GeminiUI = () => {
  const [messages, setMessages] = useState([
    { text: "Hello! How can I assist you today?", sender: "bot" },
  ]);
  const [input, setInput] = useState("");

  const sendMessage = () => {
    if (!input.trim()) return;
    const newMessages = [...messages, { text: input, sender: "user" }];
    setMessages(newMessages);
    setInput("");
    
    // Simulate AI response
    setTimeout(() => {
      setMessages((prev) => [...prev, { text: "This is a simulated response.", sender: "bot" }]);
    }, 1000);
  };

  return (
    <div className="gemini-container">
      {/* Left Panel: Chat Window */}
      <div className="chat-panel">
        <div className="chat-messages">
          {messages.map((msg, index) => (
            <div key={index} className={`chat-bubble ${msg.sender}`}>
              {msg.text}
            </div>
          ))}
        </div>
        <div className="chat-input">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Type a message..."
          />
          <button onClick={sendMessage}>Send</button>
        </div>
      </div>

      {/* Right Panel: Additional Information */}
      <div className="info-panel">
        <h2>AI Insights</h2>
        <p>Get contextual information based on your queries.</p>
      </div>
    </div>
  );
};

export default GeminiUI;

/* CSS File: GeminiUI.css */

div {
  box-sizing: border-box;
}

.gemini-container {
  display: flex;
  height: 100vh;
}

.chat-panel {
  flex: 2;
  display: flex;
  flex-direction: column;
  border-right: 1px solid #ddd;
  padding: 16px;
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding-bottom: 10px;
}

.chat-bubble {
  padding: 10px;
  margin: 5px;
  border-radius: 8px;
  max-width: 70%;
}

.user {
  background-color: #0078ff;
  color: white;
  align-self: flex-end;
}

.bot {
  background-color: #f1f1f1;
  align-self: flex-start;
}

.chat-input {
  display: flex;
  gap: 10px;
}

.chat-input input {
  flex: 1;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 5px;
}

.chat-input button {
  padding: 8px 16px;
  background-color: #0078ff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.info-panel {
  flex: 1;
  padding: 20px;
  background-color: #f9f9f9;
}
