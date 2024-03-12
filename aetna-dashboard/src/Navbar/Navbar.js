import React, { useState } from "react";
import "./Navbar.css"; // Import your CSS file

function Navbar() {
  const [selectedCategory, setSelectedCategory] = useState(null);
  const [selectedDepartment, setSelectedDepartment] = useState(null);

  const categories = ["Category 1", "Category 2", "Category 3", "Category 4"];
  const departments = [
    "Department 1",
    "Department 2",
    "Department 3",
    "Department 4",
  ];
  const data = ["Data 1", "Data 2", "Data 3", "Data 4"];

  const handleCategoryClick = (index) => {
    setSelectedCategory(index);
    setSelectedDepartment(null);
  };

  const handleDepartmentClick = (index) => {
    setSelectedDepartment(index);
  };

  return (
    <div className="navbar-container">
      <h1>Navbar</h1>
      <ul className="category-list">
        {categories.map((category, index) => (
          <li
            key={index}
            onClick={() => handleCategoryClick(index)}
            className={selectedCategory === index ? "active" : ""}
          >
            {category}
          </li>
        ))}
      </ul>
      {selectedCategory !== null && (
        <div>
          <h2>Departments</h2>
          <ul className="department-list">
            {departments.map((department, index) => (
              <li
                key={index}
                onClick={() => handleDepartmentClick(index)}
                className={selectedDepartment === index ? "active" : ""}
              >
                {department}
              </li>
            ))}
          </ul>
          {selectedDepartment !== null && (
            <div>
              <h3>Data</h3>
              <ul className="data-list">
                {data.map((item, index) => (
                  <li key={index}>{item}</li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

export default Navbar;
