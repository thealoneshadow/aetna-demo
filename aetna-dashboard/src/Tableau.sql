import { useState } from "react";

const AutoExpandTextarea = () => {
  const [text, setText] = useState("");

  return (
    <textarea
      className="input-box"
      rows="1"
      value={text}
      onChange={(e) => {
        setText(e.target.value);
        e.target.style.height = "auto";
        e.target.style.height = e.target.scrollHeight + "px";
      }}
    />
  );
};



.input-box {
    flex: 1;
    background-color: white;
    padding: 8px;
    border: none;
    outline: none;
    resize: none; /* Prevent manual resizing */
    overflow: hidden; /* Hide scrollbars */
}

.auto-expand {
    width: 100%;
    min-height: 40px;
    max-height: 200px;
    overflow-y: auto;
    padding: 8px;
    border: 1px solid #ccc;
    outline: none;
    resize: none; /* Prevent manual resizing */
    scrollbar-width: thin; /* For Firefox */
    scrollbar-color: transparent transparent; /* Hide scrollbar background */
}

/* Hide scrollbar background for Webkit (Chrome, Edge, Safari) */
.auto-expand::-webkit-scrollbar {
    width: 6px; /* Thin scrollbar */
}

.auto-expand::-webkit-scrollbar-thumb {
    background: rgba(0, 0, 0, 0.3); /* Slightly visible scrollbar handle */
    border-radius: 10px;
}

.auto-expand::-webkit-scrollbar-track {
    background: transparent; /* Hide scrollbar track */
}
