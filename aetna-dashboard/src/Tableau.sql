filters
  .filter(filter => filter.column && filter.value) // Exclude incomplete filters
  .map((filter, index) => {
    const logicalOp = index > 0 ? ` ${filter.logicalOp} ` : "";
    const column = columns.find(col => col.name === filter.column);
    
    if (!column) return ""; // Skip if column is not found

    let formattedValue = filter.value;
    
    // Validate data types
    if (column.type === "int" || column.type === "float") {
      if (isNaN(formattedValue)) {
        alert(`Invalid value: '${formattedValue}' is not a valid ${column.type} for column ${filter.column}`);
        return "";
      }
    } else if (column.type === "date") {
      formattedValue = formatDate(formattedValue); // Ensure date is formatted properly
      formattedValue = `'${formattedValue}'`; // Wrap date values in single quotes
    } else if (column.type === "string") {
      formattedValue = `'${formattedValue}'`; // Wrap strings in single quotes
    }

    return `${logicalOp}${filter.column} ${filter.operator} ${formattedValue}`;
  })
  .filter(Boolean) // Remove any empty strings from invalid filters
  .join(" ");
