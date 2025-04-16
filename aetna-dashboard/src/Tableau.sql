function areStringsSame(str1, str2) {
  const clean = str => {
    if (!str) return '';
    str = str.trim();
    
    // Remove starting and ending quotes if same
    const first = str[0];
    const last = str[str.length - 1];
    if ((first === last) && (`'"``".includes(first))) {
      str = str.slice(1, -1);
    }

    return str.trim();
  };

  return clean(str1) === clean(str2) ? "yes" : "no";
}
