{screen === 2 && (
  <>
    <h2>Configure Filters</h2>
    <button onClick={handleAddFilter} style={{ marginBottom: "10px" }}>Add Filter</button>

    {filters.map((filter, index) => (
      <div key={index} style={{ display: "flex", gap: "10px", marginBottom: "10px" }}>
        {/* Logical Operator Dropdown (except for the first filter) */}
        {index > 0 && (
          <select value={filter.logicalOp} onChange={(e) => updateFilter(index, "logicalOp", e.target.value)}>
            {logicalOperators.map((op) => (
              <option key={op} value={op}>{op}</option>
            ))}
          </select>
        )}

        {/* Column Selection */}
        <select value={filter.column} onChange={(e) => updateFilter(index, "column", e.target.value)}>
          <option value="">Select Column</option>
          {columns.map((col) => (
            <option key={col} value={col}>{col}</option>
          ))}
        </select>

        {/* Operator Selection */}
        <select value={filter.operator} onChange={(e) => updateFilter(index, "operator", e.target.value)}>
          {operators.map((op) => (
            <option key={op} value={op}>{op}</option>
          ))}
        </select>

        {/* Input for Filter Value */}
        <input type="text" value={filter.value} onChange={(e) => updateFilter(index, "value", e.target.value)} placeholder="Enter value" />

        {/* Remove Filter Button */}
        <button onClick={() => handleRemoveFilter(index)}>Remove</button>
      </div>
    ))}

    {/* Query Preview */}
    <h3>Generated Query:</h3>
    <p style={{ background: "#f4f4f4", padding: "10px", borderRadius: "5px" }}>{generateQuery()}</p>

    <button onClick={() => setScreen(3)} style={{ marginTop: "20px" }}>Next</button>
    <button onClick={() => setScreen(1)} style={{ marginTop: "20px", marginLeft: "10px" }}>Back</button>
  </>
)}


  const operators = ["=", "!=", ">", "<", ">=", "<="]; // Common operators
const logicalOperators = ["AND", "OR"];

filters
    .map((filter, index) =>
      `${index > 0 ? filter.logicalOp + " " : ""}${filter.column} ${filter.operator} '${filter.value}'`
    )
    .join(" ");
