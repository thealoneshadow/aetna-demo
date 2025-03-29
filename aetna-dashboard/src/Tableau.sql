const generateMarkdownTable = (data) => {
  if (data.length === 0) return "No data available";

  const headers = Object.keys(data[0]).join(" | ");
  const separator = Object.keys(data[0]).map(() => "---").join(" | ");
  const rows = data.map(row => Object.values(row).join(" | ")).join("\n");

  return `
| ${headers} |
| ${separator} |
${rows.split("\n").map(row => `| ${row} |`).join("\n")}
`;
};
