import React, { useState, useRef, useEffect } from "react";
import "./styles.css"; // Import your CSS file

const Dropdown = () => {
  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef(null);

  useEffect(() => {
    const handleOutsideClick = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsOpen(false);
      }
    };

    document.addEventListener("click", handleOutsideClick);

    return () => {
      document.removeEventListener("click", handleOutsideClick);
    };
  }, []);

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };

  const handleItemClick = (item) => {
    // Handle item click
    console.log("Item clicked:", item);
  };

  return (
    <div className="dropdown" ref={dropdownRef}>
      <button className="dropdown-toggle" onClick={toggleDropdown}>
        Toggle Dropdown
      </button>
      {isOpen && (
        <div className="dropdown-menu">
          <div
            className="dropdown-item"
            onClick={() => handleItemClick("Item 1")}
          >
            Item 1
          </div>
          <div
            className="dropdown-item"
            onClick={() => handleItemClick("Item 2")}
          >
            Item 2
          </div>
          <div
            className="dropdown-item"
            onClick={() => handleItemClick("Item 3")}
          >
            Item 3
          </div>
        </div>
      )}
    </div>
  );
};

export default Dropdown;
