  // Convert Blob to JSON
      const fileReader = new FileReader();
      fileReader.onload = (event) => {
        const jsonData = JSON.parse(event.target.result);
        setData(jsonData.data); // Access the "data" field
      };
      fileReader.readAsText(response.data); // Read Blob as 


             const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement("a");
    link.href = url;
    link.setAttribute("download", "data.json"); // Set file name
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link); // Cleanup




    file_path = "output.json"

    # Write data to a JSON file (streaming to avoid memory issues)
    with open(file_path, "w") as f:
        f.write('{"message": "Data fetched", "data": [')  # Start JSON object
        first = True
        for row in query_job:
            if not first:
                f.write(',')
            first = False
            json.dump(dict(row), f)  # Write row as JSON
        f.write("]}")  # End JSON object

    # Send the JSON file as a response
    return send_file(file_path, as_attachment=True, mimetype="application/json")



import React, { useState } from "react";

const columns = ["Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10"]; // Example list of columns
const aggregateFunctions = ["None", "SUM", "AVG", "MAX", "MIN"];
const filterOperators = ["=", ">", "<", ">=", "<=", "LIKE"];
const orderDirections = ["ASC", "DESC"];

const QueryBuilder = () => {
  const [screen, setScreen] = useState(1); // Track which screen to display
  const [searchQuery, setSearchQuery] = useState(""); // Track search input for filtering columns
  const [selectedColumns, setSelectedColumns] = useState([]);
  const [filters, setFilters] = useState([]);
  const [orderBy, setOrderBy] = useState([]);
  const [query, setQuery] = useState(""); // Store the generated query
  const [queryName, setQueryName] = useState("");

  const filteredColumns = columns.filter((col) => col.toLowerCase().includes(searchQuery.toLowerCase()));

  const handleColumnClick = (column) => {
    const isSelected = selectedColumns.some((col) => col.column === column);
    if (isSelected) {
      setSelectedColumns(selectedColumns.filter((col) => col.column !== column));
    } else {
      setSelectedColumns([...selectedColumns, { column, aggregate: "None", groupBy: false }]);
    }
  };

  const updateColumn = (index, field, value) => {
    const updated = [...selectedColumns];
    updated[index][field] = value;
    setSelectedColumns(updated);
  };

  const generateQuery = () => {
    const selectClause = selectedColumns
      .map((col) => (col.aggregate !== "None" ? `${col.aggregate}(${col.column}) AS ${col.aggregate}_${col.column}` : col.column))
      .join(", ");

    const whereClause = filters
      .filter((filter) => filter.column && filter.operator && filter.value)
      .map((filter) => `${filter.column} ${filter.operator} '${filter.value}'`)
      .join(" AND ");

    const groupByClause = selectedColumns
      .filter((col) => col.groupBy)
      .map((col) => col.column)
      .join(", ");

    const orderByClause = orderBy
      .filter((order) => order.column)
      .map((order) => `${order.column} ${order.direction}`)
      .join(", ");

    let query = `SELECT ${selectClause} FROM table_name`;
    if (whereClause) query += ` WHERE ${whereClause}`;
    if (groupByClause) query += ` GROUP BY ${groupByClause}`;
    if (orderByClause) query += ` ORDER BY ${orderByClause}`;
    setQuery(query);
  };

  return (
    <div style={{ padding: "20px" }}>
      {/* Screen 1: Select Columns and Configure */}
      {screen === 1 && (
        <>
          <h2>Select Columns and Configure</h2>

          {/* Search Bar */}
          <input
            type="text"
            placeholder="Search columns..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            style={{ marginBottom: "20px", padding: "10px", width: "100%", boxSizing: "border-box" }}
          />

          <div style={{ display: "flex", gap: "10px", flexWrap: "wrap", marginBottom: "20px" }}>
            {filteredColumns.map((column) => (
              <div
                key={column}
                onClick={() => handleColumnClick(column)}
                style={{
                  padding: "8px",
                  margin: "5px",
                  border: selectedColumns.some((col) => col.column === column) ? "2px solid #007bff" : "1px solid #ccc",
                  borderRadius: "4px",
                  cursor: "pointer",
                  background: selectedColumns.some((col) => col.column === column) ? "#e7f3ff" : "#f9f9f9",
                }}
              >
                {column}
              </div>
            ))}
          </div>

          <h3>Selected Columns</h3>
          {selectedColumns.map((col, index) => (
            <div key={index} style={{ display: "flex", gap: "10px", alignItems: "center" }}>
              <span>{col.column}</span>
              <select value={col.aggregate} onChange={(e) => updateColumn(index, "aggregate", e.target.value)}>
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

      {/* Other screens omitted for brevity */}

      {/* Example Screen Navigation */}
      {screen === 2 && (
        <>
          <h2>Next Screen</h2>
          <button onClick={() => setScreen(1)}>Back</button>
        </>
      )}
    </div>
  );
};

export default QueryBuilder;




import React, { useState } from "react";

const columns = ["Column1", "Column2", "Column3", "Column4"];
const aggregateFunctions = ["None", "SUM", "AVG", "MAX", "MIN"];
const filterOperators = ["=", ">", "<", ">=", "<=", "LIKE"];
const orderDirections = ["ASC", "DESC"];

const QueryBuilder = () => {
  const [screen, setScreen] = useState(1); // Track which screen to display
  const [selectedColumns, setSelectedColumns] = useState([]);
  const [filters, setFilters] = useState([]);
  const [orderBy, setOrderBy] = useState([]);
  const [query, setQuery] = useState(""); // Store the generated query
  const [queryName, setQueryName] = useState("");

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

  // Add an order-by configuration on Screen 3
  const addOrderBy = () => {
    setOrderBy([...orderBy, { column: "", direction: "ASC" }]);
  };

  // Update order-by configuration
  const updateOrderBy = (index, field, value) => {
    const updated = [...orderBy];
    updated[index][field] = value;
    setOrderBy(updated);
  };

  // Remove an order-by configuration
  const removeOrderBy = (index) => {
    setOrderBy(orderBy.filter((_, i) => i !== index));
  };

  // Generate SQL query
  const generateQuery = () => {
    const selectClause = selectedColumns
      .map((col) => (col.aggregate !== "None" ? `${col.aggregate}(${col.column}) AS ${col.aggregate}_${col.column}` : col.column))
      .join(", ");

    const groupByClause = selectedColumns
      .filter((col) => col.groupBy)
      .map((col) => col.column)
      .join(", ");

    const whereClause = filters
      .filter((filter) => filter.column && filter.operator && filter.value)
      .map((filter) => `${filter.column} ${filter.operator} '${filter.value}'`)
      .join(" AND ");

    const orderByClause = orderBy
      .filter((order) => order.column)
      .map((order) => `${order.column} ${order.direction}`)
      .join(", ");

    let query = `SELECT ${selectClause} FROM table_name`;
    if (whereClause) query += ` WHERE ${whereClause}`;
    if (groupByClause) query += ` GROUP BY ${groupByClause}`;
    if (orderByClause) query += ` ORDER BY ${orderByClause}`;
    setQuery(query);
  };

  // Handle query save and run
  const saveAndRunQuery = () => {
    alert(`Query Saved as: ${queryName}\n\nQuery:\n${query}`);
    // Logic to run the query can be added here
  };

  return (
    <div style={{ padding: "20px" }}>
      {/* Screen 1: Select Columns and Configure */}
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
                  border: selectedColumns.some((col) => col.column === column) ? "2px solid #007bff" : "1px solid #ccc",
                  borderRadius: "4px",
                  cursor: "pointer",
                  background: selectedColumns.some((col) => col.column === column) ? "#e7f3ff" : "#f9f9f9",
                }}
              >
                {column}
              </div>
            ))}
          </div>

          <h3>Selected Columns</h3>
          {selectedColumns.map((col, index) => (
            <div key={index} style={{ display: "flex", gap: "10px", alignItems: "center" }}>
              <span>{col.column}</span>
              <select value={col.aggregate} onChange={(e) => updateColumn(index, "aggregate", e.target.value)}>
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

      {/* Screen 2: Configure Filters */}
      {screen === 2 && (
        <>
          <h2>Configure Filtering Criteria</h2>
          {filters.map((filter, index) => (
            <div key={index} style={{ display: "flex", gap: "10px", alignItems: "center" }}>
              <select value={filter.column} onChange={(e) => updateFilter(index, "column", e.target.value)}>
                <option value="">Select Column</option>
                {selectedColumns.map((col) => (
                  <option key={col.column} value={col.column}>
                    {col.column}
                  </option>
                ))}
              </select>
              <select value={filter.operator} onChange={(e) => updateFilter(index, "operator", e.target.value)}>
                {filterOperators.map((op) => (
                  <option key={op} value={op}>
                    {op}
                  </option>
                ))}
              </select>
              <input type="text" value={filter.value} onChange={(e) => updateFilter(index, "value", e.target.value)} />
              <button onClick={() => removeFilter(index)}>Remove</button>
            </div>
          ))}
          <button onClick={addFilter} style={{ marginTop: "10px", padding: "10px 20px" }}>
            Add Filter
          </button>
          <div>
            <button onClick={() => setScreen(1)} style={{ marginRight: "10px", padding: "10px 20px" }}>
              Back
            </button>
            <button onClick={() => setScreen(3)} style={{ padding: "10px 20px" }}>
              Next
            </button>
          </div>
        </>
      )}

      {/* Screen 3: Configure Order By Clause */}
      {screen === 3 && (
        <>
          <h2>Configure Order By Clause</h2>
          {orderBy.map((order, index) => (
            <div key={index} style={{ display: "flex", gap: "10px", alignItems: "center" }}>
              <select value={order.column} onChange={(e) => updateOrderBy(index, "column", e.target.value)}>
                <option value="">Select Column</option>
                {selectedColumns.map((col) => (
                  <option key={col.column} value={col.column}>
                    {col.column}
                  </option>
                ))}
              </select>
              <select value={order.direction} onChange={(e) => updateOrderBy(index, "direction", e.target.value)}>
                {orderDirections.map((dir) => (
                  <option key={dir} value={dir}>
                    {dir}
                  </option>
                ))}
              </select>
              <button onClick={() => removeOrderBy(index)}>Remove</button>
            </div>
          ))}
          <button onClick={addOrderBy} style={{ marginTop: "10px", padding: "10px 20px" }}>
            Add Order By
          </button>
          <div>
            <button onClick={() => setScreen(2)} style={{ marginRight: "10px", padding: "10px 20px" }}>
              Back
            </button>
            <button onClick={() => setScreen(4)} style={{ padding: "10px 20px" }}>
              Next
            </button>
          </div>
        </>
      )}

      {/* Screen 4: Save and Run Query */}
      {screen === 4 && (
        <>
          <h2>Save and Run Query</h2>
          <div>
            <label>
              Query Name:
              <input
                type="text"
                value={queryName}
                onChange={(e) => setQueryName(e.target.value)}
                style={{ marginLeft: "10px", padding: "5px", width: "300px" }}
              />
            </label>
          </div>
          <button onClick={generateQuery} style={{ marginTop: "10px", padding: "10px 20px" }}>
            Generate Query
          </button>
          {query && (
            <div style={{ marginTop: "20px", padding: "15px", border: "1px solid #ccc" }}>
              <h3>Generated Query:</h3>
              <pre>{query}</pre>
            </div>
          )}
          <button
            onClick={saveAndRunQuery}
            style={{
              marginTop: "20px",
              padding: "10px 20px",
              background: "#007bff",
              color: "white",
              border: "none",
              borderRadius: "4px",
            }}
          >
            Save and Run Query
          </button>
          <div>
            <button onClick={() => setScreen(3)} style={{ marginTop: "10px", padding: "10px 20px" }}>
              Back
            </button>
          </div>
        </>
      )}
    </div>
  );
};

export default QueryBuilder;




import React, { useState } from "react";

const columns = ["Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10"]; // Example list of columns
const aggregateFunctions = ["None", "SUM", "AVG", "MAX", "MIN"];

const QueryBuilder = () => {
  const [screen, setScreen] = useState(1); // Track which screen to display
  const [searchQuery, setSearchQuery] = useState(""); // Track search input for filtering columns
  const [selectedColumns, setSelectedColumns] = useState([]);

  const filteredColumns = columns.filter((col) => col.toLowerCase().includes(searchQuery.toLowerCase()));

  const handleSelectColumn = (column) => {
    if (!selectedColumns.some((col) => col.column === column)) {
      setSelectedColumns([...selectedColumns, { column, aggregate: "None", groupBy: false }]);
    }
  };

  const handleRemoveColumn = (column) => {
    setSelectedColumns(selectedColumns.filter((col) => col.column !== column));
  };

  const updateColumn = (index, field, value) => {
    const updated = [...selectedColumns];
    updated[index][field] = value;
    setSelectedColumns(updated);
  };

  return (
    <div style={{ padding: "20px" }}>
      {/* Screen 1: Select Columns and Configure */}
      {screen === 1 && (
        <>
          <h2>Select Columns and Configure</h2>

          <div style={{ display: "flex", gap: "20px" }}>
            {/* Left: Available Columns */}
            <div style={{ flex: 1 }}>
              <h3>Available Columns</h3>
              <input
                type="text"
                placeholder="Search columns..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                style={{ marginBottom: "10px", padding: "10px", width: "100%", boxSizing: "border-box" }}
              />
              <table style={{ width: "100%", borderCollapse: "collapse" }}>
                <thead>
                  <tr>
                    <th style={{ border: "1px solid #ccc", padding: "8px" }}>Column Name</th>
                    <th style={{ border: "1px solid #ccc", padding: "8px" }}>Action</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredColumns.map((column) => (
                    <tr key={column}>
                      <td style={{ border: "1px solid #ccc", padding: "8px" }}>{column}</td>
                      <td style={{ border: "1px solid #ccc", padding: "8px", textAlign: "center" }}>
                        <button onClick={() => handleSelectColumn(column)}>Select</button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {/* Right: Selected Columns */}
            <div style={{ flex: 1 }}>
              <h3>Selected Columns</h3>
              {selectedColumns.length === 0 && <p>No columns selected.</p>}
              {selectedColumns.length > 0 && (
                <table style={{ width: "100%", borderCollapse: "collapse" }}>
                  <thead>
                    <tr>
                      <th style={{ border: "1px solid #ccc", padding: "8px" }}>Column Name</th>
                      <th style={{ border: "1px solid #ccc", padding: "8px" }}>Aggregate</th>
                      <th style={{ border: "1px solid #ccc", padding: "8px" }}>Group By</th>
                      <th style={{ border: "1px solid #ccc", padding: "8px" }}>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {selectedColumns.map((col, index) => (
                      <tr key={index}>
                        <td style={{ border: "1px solid #ccc", padding: "8px" }}>{col.column}</td>
                        <td style={{ border: "1px solid #ccc", padding: "8px" }}>
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
                        </td>
                        <td style={{ border: "1px solid #ccc", padding: "8px", textAlign: "center" }}>
                          <input
                            type="checkbox"
                            checked={col.groupBy}
                            onChange={(e) => updateColumn(index, "groupBy", e.target.checked)}
                          />
                        </td>
                        <td style={{ border: "1px solid #ccc", padding: "8px", textAlign: "center" }}>
                          <button onClick={() => handleRemoveColumn(col.column)}>Remove</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>

          <button onClick={() => setScreen(2)} style={{ marginTop: "20px", padding: "10px 20px" }}>
            Next
          </button>
        </>
