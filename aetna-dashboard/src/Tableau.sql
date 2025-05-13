const handleCopy = () => {
    const header = columns.map(col => col.title).join('\t');
    const rows = dataSource.map(row =>
      columns.map(col => row[col.dataIndex]).join('\t')
    );
    const textToCopy = [header, ...rows].join('\n');

    navigator.clipboard.writeText(textToCopy).then(() => {
      alert('Table copied to clipboard!');
    });
  };

 const handleCopy = () => {
    navigator.clipboard.writeText(code.trim());
    alert('Copied to clipboard!');
  };
