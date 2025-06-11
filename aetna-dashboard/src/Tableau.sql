import React, { useState, useRef } from 'react';
import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';

import BarChart from './components/charts/BarChart';
import LineChart from './components/charts/LineChart';
import PieChart from './components/charts/PieChart';
import DoughnutChart from './components/charts/DoughnutChart';
import RadarChart from './components/charts/RadarChart';
import PolarAreaChart from './components/charts/PolarAreaChart';
import BubbleChart from './components/charts/BubbleChart';
import ScatterChart from './components/charts/ScatterChart';

import './chartConfig';

const chartComponents = {
  Bar: BarChart,
  Line: LineChart,
  Pie: PieChart,
  Doughnut: DoughnutChart,
  Radar: RadarChart,
  PolarArea: PolarAreaChart,
  Bubble: BubbleChart,
  Scatter: ScatterChart
};

export default function App() {
  const [selectedChart, setSelectedChart] = useState('Bar');
  const chartRef = useRef(null);
  const ChartToRender = chartComponents[selectedChart];

  // ✅ Export as PDF
  const downloadPDF = async () => {
    const canvas = await html2canvas(chartRef.current, { scale: 2 }); // sharper render
    const imgData = canvas.toDataURL('image/png');
    const pdf = new jsPDF({
      orientation: 'landscape',
      unit: 'px',
      format: [canvas.width, canvas.height]
    });
    pdf.addImage(imgData, 'PNG', 0, 0, canvas.width, canvas.height);
    pdf.save(`${selectedChart}_chart.pdf`);
  };

  // ✅ Export as PNG
  const downloadPNG = async () => {
    const canvas = await html2canvas(chartRef.current, { scale: 2 });
    const link = document.createElement('a');
    link.download = `${selectedChart}_chart.png`;
    link.href = canvas.toDataURL('image/png', 1.0); // highest quality
    link.click();
  };

  return (
    <div style={{ padding: '20px' }}>
      <h1>Chart Viewer</h1>

      <select
        value={selectedChart}
        onChange={(e) => setSelectedChart(e.target.value)}
        style={{ padding: '8px', marginBottom: '20px' }}
      >
        {Object.keys(chartComponents).map((chart) => (
          <option key={chart} value={chart}>
            {chart} Chart
          </option>
        ))}
      </select>

      <div ref={chartRef} style={{ maxWidth: '600px', marginBottom: '20px' }}>
        <ChartToRender />
      </div>

      <div style={{ display: 'flex', gap: '10px' }}>
        <button onClick={downloadPDF} style={{ padding: '10px 20px' }}>
          Download as PDF
        </button>
        <button onClick={downloadPNG} style={{ padding: '10px 20px' }}>
          Download as PNG
        </button>
      </div>
    </div>
  );
}
