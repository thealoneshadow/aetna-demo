 tableauViz.addEventListener("firstinteractive", () => {
      console.log("Tableau Viz is interactive");

      // Get the workbook and active sheet
      const workbook = tableauViz.getWorkbook();
      const activeSheet = workbook.getActiveSheet();

      // Example: Listen for filter changes
      activeSheet.addEventListener("filterchange", (event) => {
        console.log("Filter changed:", event);
      });

      // Example: Listen for parameter changes
      workbook.addEventListener("parameterchange", (event) => {
        console.log("Parameter changed:", event);
      });


  import React, { useState } from "react";

// Mock data
const columns = ["Column1", "Column2", "Column3"];
const aggregateFunctions = ["None", "SUM", "AVG", "MAX", "MIN"];
const operators = ["=", "!=", ">", "<", ">=", "<="];

const QueryBuilder = () => {
  const [selectedColumns, setSelectedColumns] = useState([]);
  const [filters, setFilters] = useState([]);

  // Screen 1 Handlers
  const addColumn = () => {
    setSelectedColumns([...selectedColumns, { column: "", aggregate: "None" }]);
  };

  const updateColumn = (index, field, value) => {
    const updated = [...selectedColumns];
    updated[index][field] = value;
    setSelectedColumns(updated);
  };

  const removeColumn = (index) => {
    setSelectedColumns(selectedColumns.filter((_, i) => i !== index));
  };

  // Screen 2 Handlers
  const addFilter = () => {
    setFilters([...filters, { column: "", operator: "=", value: "", logic: "AND" }]);
  };

  const updateFilter = (index, field, value) => {
    const updated = [...filters];
    updated[index][field] = value;
    setFilters(updated);
  };

  const removeFilter = (index) => {
    setFilters(filters.filter((_, i) => i !== index));
  };

  return (
    <div>
      {/* Screen 1: Select Columns */}
      <h2>Screen 1: Select Columns and Apply Aggregate Functions</h2>
      {selectedColumns.map((col, index) => (
        <div key={index} style={{ display: "flex", gap: "10px", marginBottom: "10px" }}>
          <select
            value={col.column}
            onChange={(e) => updateColumn(index, "column", e.target.value)}
          >
            <option value="">Select Column</option>
            {columns.map((column) => (
              <option key={column} value={column}>
                {column}
              </option>
            ))}
          </select>
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
          <button onClick={() => removeColumn(index)}>Remove</button>
        </div>
      ))}
      <button onClick={addColumn}>Add Column</button>

      {/* Screen 2: Configure Filters */}
      <h2>Screen 2: Configure Filtering Criteria</h2>
      {filters.map((filter, index) => (
        <div key={index} style={{ display: "flex", gap: "10px", marginBottom: "10px" }}>
          <select
            value={filter.column}
            onChange={(e) => updateFilter(index, "column", e.target.value)}
          >
            <option value="">Select Column</option>
            {columns.map((column) => (
              <option key={column} value={column}>
                {column}
              </option>
            ))}
          </select>
          <select
            value={filter.operator}
            onChange={(e) => updateFilter(index, "operator", e.target.value)}
          >
            {operators.map((op) => (
              <option key={op} value={op}>
                {op}
              </option>
            ))}
          </select>
          <input
            type="text"
            placeholder="Value"
            value={filter.value}
            onChange={(e) => updateFilter(index, "value", e.target.value)}
          />
          {index > 0 && (
            <select
              value={filter.logic}
              onChange={(e) => updateFilter(index, "logic", e.target.value)}
            >
              <option value="AND">AND</option>
              <option value="OR">OR</option>
            </select>
          )}
          <button onClick={() => removeFilter(index)}>Remove</button>
        </div>
      ))}
      <button onClick={addFilter}>Add Filter</button>
    </div>
  );
};

export default QueryBuilder;
