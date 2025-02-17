import React, { useState, useEffect } from "react";
import { Select } from "antd";

const { Option } = Select;

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
  const [selectedTable, setSelectedTable] = useState("");

  useEffect(() => {
    if (selectedDashboard) {
      const tables = data.filter((item) => item.dashboard === selectedDashboard);
      setFilteredTables(tables);
      setShowTimePeriod(tables.some(item => timePeriods.includes(item.timePeriod)));
      setSelectedTimePeriod(showTimePeriod ? tables.find(item => timePeriods.includes(item.timePeriod))?.timePeriod || "" : "");
      setSelectedTable(tables[0]?.tableName || "");
    } else {
      setFilteredTables([]);
      setShowTimePeriod(false);
    }
  }, [selectedDashboard]);

  useEffect(() => {
    if (selectedTimePeriod) {
      const filtered = data.filter(
        (item) => item.dashboard === selectedDashboard && (item.timePeriod === selectedTimePeriod || item.timePeriod === "")
      );
      setFilteredTables(filtered);
      setSelectedTable(filtered[0]?.tableName || "");
    }
  }, [selectedTimePeriod]);

  return (
    <div>
      <label>Dashboard:</label>
      <Select value={selectedDashboard} onChange={setSelectedDashboard} style={{ width: 200 }}>
        {dashboards.map((dashboard) => (
          <Option key={dashboard} value={dashboard}>{dashboard}</Option>
        ))}
      </Select>

      {showTimePeriod && (
        <>
          <label>Time Period:</label>
          <Select value={selectedTimePeriod} onChange={setSelectedTimePeriod} style={{ width: 200 }}>
            {timePeriods.map((period) => (
              <Option key={period} value={period}>{period}</Option>
            ))}
          </Select>
        </>
      )}

      <label>Tables:</label>
      <Select value={selectedTable} onChange={setSelectedTable} style={{ width: 200 }}>
        {filteredTables.map((table) => (
          <Option key={table.tableName} value={table.tableName}>{table.tableName}</Option>
        ))}
      </Select>
    </div>
  );
};

export default CascadingDropdowns;
