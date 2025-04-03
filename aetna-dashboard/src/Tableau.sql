const TableMarkdown = ({ data }) => {
  // Convert array to Markdown table
  const generateMarkdownTable = (arr) => {
    if (!arr.length) return "No data available";

    const headers = Object.keys(arr[0]).join(" | ");
    const separator = Object.keys(arr[0]).map(() => "---").join(" | ");
    const rows = arr.map(row => Object.values(row).join(" | ")).join("\n");

    return `| ${headers} |\n| ${separator} |\n${rows.split("\n").map(row => `| ${row} |`).join("\n")}`;
  };

  return <ReactMarkdown>{generateMarkdownTable(data)}</ReactMarkdown>;
};
