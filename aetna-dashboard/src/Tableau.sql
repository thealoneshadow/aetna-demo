function areStringsSame(str1, str2) {
  const clean = str => {
    if (!str) return '';

    // Trim spaces and convert to lowercase (optional, if case-insensitive)
    str = str.trim();

    // Remove ```sql or ``` if present at start and end
    if (str.startsWith('```sql')) {
      str = str.slice(6);
    } else if (str.startsWith('```')) {
      str = str.slice(3);
    }

    if (str.endsWith('```')) {
      str = str.slice(0, -3);
    }

    // Remove any surrounding quotes or backticks
    const quotes = [`"`, `'`, '`'];
    while (quotes.includes(str[0]) && quotes.includes(str[str.length - 1])) {
      str = str.slice(1, -1).trim();
    }

    return str.trim().toLowerCase(); // toLowerCase is optional
  };

  return clean(str1) === clean(str2) ? "yes" : "no";
}
