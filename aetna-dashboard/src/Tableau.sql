import React, { useState } from "react";
import { DndProvider, useDrag, useDrop } from "react-dnd";
import { HTML5Backend } from "react-dnd-html5-backend";

// Mock data
const columns = ["Column1", "Column2", "Column3", "Column4"];
const aggregateFunctions = ["None", "SUM", "AVG", "MAX", "MIN"];

const ColumnItem = ({ column, onDrop, onClick, isSelected }) => {
  const [, drag] = useDrag(() => ({
    type: "COLUMN",
    item: { column },
  }));

  return (
    <div
      ref={drag}
      onClick={() => onClick(column)}
      style={{
        padding: "8px",
        margin: "5px",
        border: isSelected ? "2px solid #007bff" : "1px solid #ccc",
        borderRadius: "4px",
        cursor: "grab",
        background: isSelected ? "#e7f3ff" : "#f9f9f9",
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

  // Handle Drag-and-Drop
  const handleDrop = (column) => {
    if (!selectedColumns.find((col) => col.column === column)) {
      setSelectedColumns([...selectedColumns, { column, aggregate: "None", groupBy: false }]);
    }
  };

  // Handle Click
  const handleClick = (column) => {
    if (!selectedColumns.find((col) => col.column === column)) {
      setSelectedColumns([...selectedColumns, { column, aggregate: "None", groupBy: false }]);
    } else {
      // Remove column if already selected
      setSelectedColumns(selectedColumns.filter((col) => col.column !== column));
    }
  };

  // Update Column
  const updateColumn = (index, field, value) => {
    const updated = [...selectedColumns];
    updated[index][field] = value;
    setSelectedColumns(updated);
  };

  // Remove Column
  const removeColumn = (index) => {
    setSelectedColumns(selectedColumns.filter((_, i) => i !== index));
  };

  return (
    <DndProvider backend={HTML5Backend}>
      <div style={{ padding: "20px" }}>
        {/* Available Columns */}
        <h2>Available Columns</h2>
        <div style={{ display: "flex", gap: "10px", flexWrap: "wrap", marginBottom: "20px" }}>
          {columns.map((column) => (
            <ColumnItem
              key={column}
              column={column}
              onDrop={handleDrop}
              onClick={handleClick}
              isSelected={selectedColumns.some((col) => col.column === column)}
            />
          ))}
        </div>

        {/* Drop Area for Selected Columns */}
        <h2>Selected Columns</h2>
        <DropArea onDrop={handleDrop}>
          {selectedColumns.length === 0 && <p>Drag or click to add columns here.</p>}
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
              <button onClick={() => removeColumn(index)}>Remove</button>
            </div>
          ))}
        </DropArea>
      </div>
    </DndProvider>
  );
};

export default QueryBuilder;
