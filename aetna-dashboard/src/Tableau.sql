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
            <p style={{ color: "green", fontWeight: "bold" }}>Feedback Submitted</p>
          ) : (
            <div style={{ display: "flex", gap: "10px", cursor: "pointer" }}>
              <FaThumbsUp
                color="green"
                size={20}
                onClick={() => handleFeedback(msg.id, "up")}
              />
              <FaThumbsDown
                color="red"
                size={20}
                onClick={() => handleFeedback(msg.id, "down")}
              />
            </div>
          )}
        </div>
      ))}
    </div>
  );
};

export default ChatApp;
