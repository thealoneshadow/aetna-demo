filters
  .filter(filter => filter.column && filter.value) // Exclude incomplete filters
  .map((filter, index) => {
    const logicalOp = index > 0 ? ` ${filter.logicalOp} ` : "";
    const columnType = columns.find(col => col.name === filter.column)?.type;
    
    let formattedValue = filter.value;
    if (columnType === "date") {
      formattedValue = formatDate(filter.value); // Ensure date is formatted properly
      formattedValue = `'${formattedValue}'`; // Wrap date values in single quotes
    } else if (columnType === "string") {
      formattedValue = `'${formattedValue}'`; // Wrap strings in single quotes
    }

    return `${logicalOp}${filter.column} ${filter.operator} ${formattedValue}`;
  })
  .join(" ");

