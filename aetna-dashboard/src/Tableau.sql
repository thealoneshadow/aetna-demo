import React, { useState } from "react";

const columns = ["Column1", "Column2", "Column3", "Column4"];
const aggregateFunctions = ["None", "SUM", "AVG", "MAX", "MIN"];
const filterOperators = ["=", ">", "<", ">=", "<=", "LIKE"];

const QueryBuilder = () => {
  const [screen, setScreen] = useState(1); // Track which screen to display
  const [selectedColumns, setSelectedColumns] = useState([]);
  const [filters, setFilters] = useState([]);

  // Handle column selection on Screen 1
  const handleColumnClick = (column) => {
    const isSelected = selectedColumns.some((col) => col.column === column);
    if (isSelected) {
      setSelectedColumns(selectedColumns.filter((col) => col.column !== column));
    } else {
      setSelectedColumns([...selectedColumns, { column, aggregate: "None", groupBy: false }]);
    }
  };

  // Update column configuration
  const updateColumn = (index, field, value) => {
    const updated = [...selectedColumns];
    updated[index][field] = value;
    setSelectedColumns(updated);
  };

  // Add a filter on Screen 2
  const addFilter = () => {
    setFilters([...filters, { column: "", operator: "=", value: "" }]);
  };

  // Update filter configuration
  const updateFilter = (index, field, value) => {
    const updated = [...filters];
    updated[index][field] = value;
    setFilters(updated);
  };

  // Remove a filter
  const removeFilter = (index) => {
    setFilters(filters.filter((_, i) => i !== index));
  };

  return (
    <div style={{ padding: "20px" }}>
      {screen === 1 && (
        <>
          <h2>Select Columns and Configure</h2>
          <div style={{ display: "flex", gap: "10px", flexWrap: "wrap", marginBottom: "20px" }}>
            {columns.map((column) => (
              <div
                key={column}
                onClick={() => handleColumnClick(column)}
                style={{
                  padding: "8px",
                  margin: "5px",
                  border: selectedColumns.some((col) => col.column === column)
                    ? "2px solid #007bff"
                    : "1px solid #ccc",
                  borderRadius: "4px",
                  cursor: "pointer",
                  background: selectedColumns.some((col) => col.column === column)
                    ? "#e7f3ff"
                    : "#f9f9f9",
                }}
              >
                {column}
              </div>
            ))}
          </div>

          <h3>Selected Columns</h3>
          {selectedColumns.map((col, index) => (
            <div
              key={index}
              style={{
                display: "flex",
                alignItems: "center",
                gap: "10px",
                marginBottom: "10px",
                padding: "8px",
                border: "1px solid #ccc",
                borderRadius: "4px",
                background: "#fff",
              }}
            >
              <span>{col.column}</span>
              <select
                value={col.aggregate}
                onChange={(e) => updateColumn(index, "aggregate", e.target.value)}
              >
                {aggregateFunctions.map((func) => (
                  <option key={func} value={func}>
                    {func}
                  </option>
                ))}
              </select>
              <label>
                <input
                  type="checkbox"
                  checked={col.groupBy}
                  onChange={(e) => updateColumn(index, "groupBy", e.target.checked)}
                />
                Group By
              </label>
            </div>
          ))}

          <button onClick={() => setScreen(2)} style={{ marginTop: "20px", padding: "10px 20px" }}>
            Next
          </button>
        </>
      )}

      {screen === 2 && (
        <>
          <h2>Configure Filtering Criteria</h2>
          {filters.map((filter, index) => (
            <div
              key={index}
              style={{
                display: "flex",
                alignItems: "center",
                gap: "10px",
                marginBottom: "10px",
                padding: "8px",
                border: "1px solid #ccc",
                borderRadius: "4px",
                background: "#fff",
              }}
            >
              <select
                value={filter.column}
                onChange={(e) => updateFilter(index, "column", e.target.value)}
              >
                <option value="">Select Column</option>
                {selectedColumns.map((col) => (
                  <option key={col.column} value={col.column}>
                    {col.column}
                  </option>
                ))}
              </select>
              <select
                value={filter.operator}
                onChange={(e) => updateFilter(index, "operator", e.target.value)}
              >
                {filterOperators.map((op) => (
                  <option key={op} value={op}>
                    {op}
                  </option>
                ))}
              </select>
              <input
                type="text"
                value={filter.value}
                onChange={(e) => updateFilter(index, "value", e.target.value)}
                placeholder="Enter value"
              />
              <button onClick={() => removeFilter(index)}>Remove</button>
            </div>
          ))}
          <button onClick={addFilter} style={{ marginTop: "10px", padding: "10px 20px" }}>
            Add Filter
          </button>

          <div style={{ marginTop: "20px" }}>
            <button onClick={() => setScreen(1)} style={{ marginRight: "10px", padding: "10px 20px" }}>
              Back
            </button>
            <button style={{ padding: "10px 20px" }}>Generate Query</button>
          </div>
        </>
      )}
    </div>
  );
};

export default QueryBuilder;
