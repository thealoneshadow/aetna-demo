import React, { useState } from "react";
import "./App.css"; // Import CSS file

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
      {/* Sidebar */}
      <div className="sidebar">
        <img src="https://via.placeholder.com/80" alt="Magic AI Logo" className="logo" />
        <h1 className="sidebar-title">Magic AI</h1>
      </div>

      {/* Chat Area */}
      <div className="chat-area">
        <div className="messages-container">
          {messages.map((msg, index) => (
            <div key={index} className={`message ${msg.sender === "user" ? "user-message" : "ai-message"}`}>
              {msg.text}
            </div>
          ))}
        </div>

        {/* Input Box */}
        <div className="input-container">
          <input
            type="text"
            className="chat-input"
            placeholder="Ask something..."
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && sendMessage()}
          />
          <button onClick={sendMessage} className="send-button">Send</button>
        </div>
      </div>
    </div>
  );
};

export default App;




/* Overall Chat Layout */
.chat-container {
  display: flex;
  height: 100vh;
  background-color: #1e1e2e;
  color: white;
}

/* Sidebar */
.sidebar {
  width: 25%;
  background: linear-gradient(to bottom, #4c00ff, #9900ff);
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
}

.logo {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  margin-bottom: 15px;
}

.sidebar-title {
  font-size: 24px;
  font-weight: bold;
}

/* Chat Area */
.chat-area {
  width: 75%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

/* Messages Container */
.messages-container {
  flex-grow: 1;
  padding: 20px;
  overflow-y: auto;
}

/* Chat Messages */
.message {
  max-width: 60%;
  padding: 12px;
  border-radius: 12px;
  margin: 8px 0;
}

.user-message {
  background-color: #007bff;
  align-self: flex-end;
  text-align: right;
}

.ai-message {
  background-color: #44475a;
  align-self: flex-start;
  text-align: left;
}

/* Input Box */
.input-container {
  display: flex;
  background: #282a36;
  padding: 10px;
  border-top: 2px solid #444;
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
  background: #4c00ff;
  border: none;
  color: white;
  padding: 10px 20px;
  cursor: pointer;
  border-radius: 8px;
  font-weight: bold;
  transition: 0.3s;
}

.send-button:hover {
  background: #7000ff;
}

