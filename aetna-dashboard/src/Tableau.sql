import React, { useState, useEffect } from "react";

const data = [
  { dashboard: "Sales", timePeriod: "AEP", tableName: "sales_q1" },
  { dashboard: "Sales", timePeriod: "OEP", tableName: "sales_q2" },
  { dashboard: "Marketing", timePeriod: "SEP", tableName: "marketing_q3" },
  { dashboard: "Marketing", timePeriod: "", tableName: "marketing_overview" },
  { dashboard: "Finance", timePeriod: "AEP", tableName: "finance_q1" },
  { dashboard: "Finance", timePeriod: "OEP", tableName: "finance_q2" }
];

const CascadingDropdowns = () => {
  const [selectedDashboard, setSelectedDashboard] = useState("");
  const [selectedTimePeriod, setSelectedTimePeriod] = useState("");
  const [filteredTables, setFilteredTables] = useState([]);

  useEffect(() => {
    if (selectedDashboard) {
      const tables = data.filter((item) => item.dashboard === selectedDashboard);
      setFilteredTables(tables);
    } else {
      setFilteredTables([]);
    }
  }, [selectedDashboard]);

  useEffect(() => {
    if (selectedTimePeriod) {
      setFilteredTables((prevTables) =>
        prevTables.filter((item) =>
          item.timePeriod === selectedTimePeriod || item.timePeriod === ""
        )
      );
    }
  }, [selectedTimePeriod]);

  const dashboards = [...new Set(data.map((item) => item.dashboard))];
  const timePeriods = ["AEP", "OEP", "SEP", ""];

  return (
    <div>
      <label>Dashboard:</label>
      <select onChange={(e) => { setSelectedDashboard(e.target.value); setSelectedTimePeriod(""); }}>
        <option value="">Select Dashboard</option>
        {dashboards.map((dashboard) => (
          <option key={dashboard} value={dashboard}>{dashboard}</option>
        ))}
      </select>

      <label>Time Period:</label>
      <select onChange={(e) => setSelectedTimePeriod(e.target.value)} disabled={!selectedDashboard}>
        <option value="">Select Time Period</option>
        {timePeriods.map((period) => (
          <option key={period} value={period}>{period || "(Empty)"}</option>
        ))}
      </select>

      <label>Tables:</label>
      <select disabled={!selectedDashboard || filteredTables.length === 0}>
        <option value="">Select Table</option>
        {filteredTables.map((table) => (
          <option key={table.tableName} value={table.tableName}>{table.tableName}</option>
        ))}
      </select>
    </div>
  );
};

export default CascadingDropdowns;
