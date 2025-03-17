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
    min-height: 40px; /* Default height */
    max-height: 200px; /* Restrict max height */
    overflow-y: auto; /* Show vertical scroll when max height is reached */
    padding: 8px;
    border: 1px solid #ccc;
    outline: none;
    resize: none; /* Prevent manual resizing */
}
