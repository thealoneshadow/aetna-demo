import React, { useState } from "react";
import { DndProvider, useDrag, useDrop } from "react-dnd";
import { HTML5Backend } from "react-dnd-html5-backend";

// Mock data
const columns = ["Column1", "Column2", "Column3", "Column4"];
const aggregateFunctions = ["None", "SUM", "AVG", "MAX", "MIN"];
const operators = ["=", "!=", ">", "<", ">=", "<="];

const ColumnItem = ({ column, onDrop }) => {
  const [, drag] = useDrag(() => ({
    type: "COLUMN",
    item: { column },
  }));
  return (
    <div
      ref={drag}
      style={{
        padding: "8px",
        margin: "5px",
        border: "1px solid #ccc",
        borderRadius: "4px",
        cursor: "grab",
        background: "#f9f9f9",
      }}
    >
      {column}
    </div>
  );
};

const DropArea = ({ onDrop, children }) => {
  const [, drop] = useDrop(() => ({
    accept: "COLUMN",
    drop: (item) => onDrop(item.column),
  }));
  return (
    <div
      ref={drop}
      style={{
        minHeight: "100px",
        padding: "10px",
        border: "2px dashed #ccc",
        borderRadius: "4px",
        background: "#f4f4f4",
        marginBottom: "20px",
      }}
    >
      {children}
    </div>
  );
};

const QueryBuilder = () => {
  const [selectedColumns, setSelectedColumns] = useState([]);
  const [filters, setFilters] = useState([]);

  // Handle Drag and Drop
  const handleDrop = (column) => {
    if (!selectedColumns.find((col) => col.column === column)) {
      setSelectedColumns([...selectedColumns, { column, aggregate: "None", groupBy: false }]);
    }
  };

  // Update Selected Columns
  const updateColumn = (index, field, value) => {
    const updated = [...selectedColumns];
    updated[index][field] = value;
    setSelectedColumns(updated);
  };

  // Remove Column
  const removeColumn = (index) => {
    setSelectedColumns(selectedColumns.filter((_, i) => i !== index));
  };

  // Add Filters
  const addFilter = () => {
    setFilters([...filters, { column: "", operator: "=", value: "", logic: "AND" }]);
  };

  const updateFilter = (index, field, value) => {
    const updated = [...filters];
    updated[index][field] = value;
    setFilters(updated);
  };

  return (
    <DndProvider backend={HTML5Backend}>
      <div style={{ display: "flex", flexDirection: "column", padding: "20px" }}>
        {/* Column Selection */}
        <h2>Drag Columns to Select and Configure</h2>
        <div style={{ display: "flex", gap: "10px", flexWrap: "wrap", marginBottom: "20px" }}>
          {columns.map((column) => (
            <ColumnItem key={column} column={column} />
          ))}
        </div>

        {/* Drop Area for Selected Columns */}
        <DropArea onDrop={handleDrop}>
          <h3>Selected Columns</h3>
          {selectedColumns.map((col, index) => (
            <div
              key={index}
              style={{
                display: "flex",
                alignItems: "center",
                gap: "10px",
                marginBottom: "10px",
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
              <button onClick={() => removeColumn(index)}>Remove</button>
            </div>
          ))}
        </DropArea>

        {/* Filtering Section */}
        <h2>Configure Filtering Criteria</h2>
        {filters.map((filter, index) => (
          <div key={index} style={{ display: "flex", gap: "10px", marginBottom: "10px" }}>
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
            <button onClick={() => setFilters(filters.filter((_, i) => i !== index))}>
              Remove
            </button>
          </div>
        ))}
        <button onClick={addFilter}>Add Filter</button>
      </div>
    </DndProvider>
  );
};

export default QueryBuilder;
