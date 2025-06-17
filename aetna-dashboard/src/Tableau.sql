const totals = {};

  arr.forEach(obj => {
    Object.entries(obj).forEach(([key, value]) => {
      if (value !== "") {
        totals[key] = (totals[key] || 0) + Number(value);
      }
    });
  });

  const labels = Object.keys(totals);
  const dataValues = Object.values(totals);
