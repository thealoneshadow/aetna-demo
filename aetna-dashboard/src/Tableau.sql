import { Line } from 'react-chartjs-2';

export default function LineChart() {
  const data = {
    labels: ['Jan', 'Feb', 'Mar'],
    datasets: [{
      label: 'Sales',
      data: [3, 2, 6],
      fill: true,
      borderColor: 'rgb(75, 192, 192)',
      tension: 0.4
    }]
  };

  return <Line data={data} />;
}



\import { Bar } from 'react-chartjs-2';

export default function BarChart() {
  const data = {
    labels: ['Red', 'Blue', 'Yellow'],
    datasets: [{
      label: 'Votes',
      data: [12, 19, 3],
      backgroundColor: ['#f87171', '#60a5fa', '#facc15'],
    }]
  };

  return <Bar data={data} />;
}


import { Pie } from 'react-chartjs-2';

export default function PieChart() {
  const data = {
    labels: ['Apple', 'Samsung', 'OnePlus'],
    datasets: [{
      label: 'Market Share',
      data: [40, 35, 25],
      backgroundColor: ['#ef4444', '#3b82f6', '#10b981']
    }]
  };

  return <Pie data={data} />;
}




import { Doughnut } from 'react-chartjs-2';

export default function DoughnutChart() {
  const data = {
    labels: ['Used', 'Free'],
    datasets: [{
      data: [70, 30],
      backgroundColor: ['#8b5cf6', '#fcd34d']
    }]
  };

  return <Doughnut data={data} />;
}




import { Radar } from 'react-chartjs-2';

export default function RadarChart() {
  const data = {
    labels: ['Running', 'Swimming', 'Cycling'],
    datasets: [{
      label: 'Fitness',
      data: [20, 30, 50],
      backgroundColor: 'rgba(34,197,94,0.2)',
      borderColor: '#22c55e'
    }]
  };

  return <Radar data={data} />;
}



import { PolarArea } from 'react-chartjs-2';

export default function PolarAreaChart() {
  const data = {
    labels: ['A', 'B', 'C'],
    datasets: [{
      data: [11, 16, 7],
      backgroundColor: ['#0ea5e9', '#f43f5e', '#14b8a6']
    }]
  };

  return <PolarArea data={data} />;
}


import { Bubble } from 'react-chartjs-2';

export default function BubbleChart() {
  const data = {
    datasets: [{
      label: 'Bubble dataset',
      data: [{ x: 10, y: 20, r: 15 }, { x: 15, y: 10, r: 10 }],
      backgroundColor: '#e11d48'
    }]
  };

  return <Bubble data={data} />;
}







import React, { useState } from 'react';

// Import all charts
import BarChart from './components/charts/BarChart';
import LineChart from './components/charts/LineChart';
import PieChart from './components/charts/PieChart';
import DoughnutChart from './components/charts/DoughnutChart';
import RadarChart from './components/charts/RadarChart';
import PolarAreaChart from './components/charts/PolarAreaChart';
import BubbleChart from './components/charts/BubbleChart';
import ScatterChart from './components/charts/ScatterChart';

import './chartConfig'; // register ChartJS

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

  const ChartToRender = chartComponents[selectedChart];

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

      <div style={{ maxWidth: '600px' }}>
        <ChartToRender />
      </div>
    </div>
  );
}
