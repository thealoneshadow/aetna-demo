import React, { useState } from "react";
import "./App.css";

const App = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState("");

  const sendMessage = () => {
    if (!input.trim()) return;

    const newMessages = [...messages, { text: input, sender: "user" }];
    setMessages(newMessages);
    setInput("");

    setTimeout(() => {
      setMessages([...newMessages, { text: "Magic AI Response ✨", sender: "ai" }]);
    }, 1000);
  };

  return (
    <div className="chat-container">
      {/* Messages */}
      <div className="chat-messages">
        {messages.map((msg, index) => (
          <div key={index} className={`message ${msg.sender === "user" ? "user-message" : "ai-message"}`}>
            {msg.sender === "ai" && <span className="ai-logo">🔮</span>}
            {msg.text}
          </div>
        ))}
      </div>

      {/* Input */}
      <div className="chat-input-container">
        <input
          type="text"
          className="chat-input"
          placeholder="Send a message..."
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && sendMessage()}
        />
        <button onClick={sendMessage} className="send-button">➤</button>
      </div>
    </div>
  );
};

export default App;




/* Global Styles */
body {
  background-color: #343541;
  color: white;
  font-family: "Arial", sans-serif;
  margin: 0;
  padding: 0;
}

/* Chat Container */
.chat-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  max-width: 900px;
  margin: auto;
  padding: 20px;
}

/* Chat Messages */
.chat-messages {
  flex-grow: 1;
  overflow-y: auto;
  padding-bottom: 10px;
}

/* Message Styling */
.message {
  max-width: 75%;
  padding: 12px;
  margin: 8px 0;
  border-radius: 12px;
  display: flex;
  align-items: center;
}

.user-message {
  background-color: #0a84ff;
  color: white;
  align-self: flex-end;
  text-align: right;
}

.ai-message {
  background-color: #44475a;
  color: white;
  align-self: flex-start;
  text-align: left;
}

/* AI Logo */
.ai-logo {
  margin-right: 10px;
}

/* Input Box */
.chat-input-container {
  display: flex;
  background: #40414F;
  padding: 10px;
  border-radius: 8px;
}

.chat-input {
  flex: 1;
  background: transparent;
  border: none;
  color: white;
  font-size: 16px;
  padding: 10px;
  outline: none;
}

.send-button {
  background: #0a84ff;
  border: none;
  color: white;
  padding: 10px 15px;
  cursor: pointer;
  border-radius: 6px;
  transition: 0.3s;
}

.send-button:hover {
  background: #005ecb;
}
