import React, { useState } from "react";

const Navbar = () => {
  const [dropdownOpen, setDropdownOpen] = useState(false);

  const toggleDropdown = () => {
    setDropdownOpen(!dropdownOpen);
  };

  const NavbarItem = ({ title, children }) => {
    const [subDropdownOpen, setSubDropdownOpen] = useState(false);

    const toggleSubDropdown = () => {
      setSubDropdownOpen(!subDropdownOpen);
    };

    return (
      <li className="navbar-item">
        <div onClick={toggleSubDropdown} className="navbar-item-title">
          {title}
        </div>
        {subDropdownOpen && (
          <ul className="sub-dropdown">
            {children.map((item, index) => (
              <li key={index}>{item}</li>
            ))}
          </ul>
        )}
      </li>
    );
  };

  return (
    <nav className="navbar">
      <ul className="navbar-list">
        <NavbarItem title="Item 1">
          {["Sub Item 1", "Sub Item 2", "Sub Item 3"]}
        </NavbarItem>
        <NavbarItem title="Item 2">
          {["Sub Item 1", "Sub Item 2", "Sub Item 3"]}
        </NavbarItem>
        <NavbarItem title="Item 3">
          {["Sub Item 1", "Sub Item 2", "Sub Item 3"]}
        </NavbarItem>
        <NavbarItem title="Item 4">
          {["Sub Item 1", "Sub Item 2", "Sub Item 3"]}
        </NavbarItem>
      </ul>
    </nav>
  );
};

export default Navbar;
