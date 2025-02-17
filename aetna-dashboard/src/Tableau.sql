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
  const dashboards = [...new Set(data.map((item) => item.dashboard))];
  const timePeriods = ["AEP", "OEP", "SEP"];

  const [selectedDashboard, setSelectedDashboard] = useState(dashboards[0] || "");
  const [filteredTables, setFilteredTables] = useState([]);
  const [selectedTimePeriod, setSelectedTimePeriod] = useState("");
  const [showTimePeriod, setShowTimePeriod] = useState(false);

  useEffect(() => {
    if (selectedDashboard) {
      const tables = data.filter((item) => item.dashboard === selectedDashboard);
      setFilteredTables(tables);
      setShowTimePeriod(tables.some(item => timePeriods.includes(item.timePeriod)));
      setSelectedTimePeriod(showTimePeriod ? tables[0]?.timePeriod || "" : "");
    } else {
      setFilteredTables([]);
      setShowTimePeriod(false);
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

  return (
    <div>
      <label>Dashboard:</label>
      <select value={selectedDashboard} onChange={(e) => setSelectedDashboard(e.target.value)}>
        {dashboards.map((dashboard) => (
          <option key={dashboard} value={dashboard}>{dashboard}</option>
        ))}
      </select>

      {showTimePeriod && (
        <>
          <label>Time Period:</label>
          <select value={selectedTimePeriod} onChange={(e) => setSelectedTimePeriod(e.target.value)}>
            {timePeriods.map((period) => (
              <option key={period} value={period}>{period}</option>
            ))}
          </select>
        </>
      )}

      <label>Tables:</label>
      <select>
        {filteredTables.map((table) => (
          <option key={table.tableName} value={table.tableName}>{table.tableName}</option>
        ))}
      </select>
    </div>
  );
};

export default CascadingDropdowns;
