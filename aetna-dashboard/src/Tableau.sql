const normalizeValue = (input) => {
  if (Array.isArray(input)) {
    return input.length > 0 ? input[0] : ''; // return first if array
  } else if (typeof input === 'string') {
    return input; // return as-is
  } else {
    return ''; // fallback
  }
};

// ✅ Usage:
const value = normalizeValue(myVar);
