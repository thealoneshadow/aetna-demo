// ✅ File: AreaChart.jsx
import { Line } from 'react-chartjs-2';

export const AreaChart = ({ labels, values }) => {
  const data = {
    labels,
    datasets: [
      {
        label: 'Area Chart',
        data: values,
        fill: true,
        backgroundColor: 'rgba(75,192,192,0.2)',
        borderColor: 'rgba(75,192,192,1)',
        tension: 0.4,
      },
    ],
  };

  const options = {
    responsive: true,
    plugins: {
      legend: { position: 'top' },
    },
  };

  return <Line data={data} options={options} />;
};


// ✅ File: StackedBarChart.jsx
import { Bar } from 'react-chartjs-2';

export const StackedBarChart = ({ labels, values }) => {
  const data = {
    labels,
    datasets: [
      {
        label: 'Series A',
        data: values,
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
        stack: 'Stack 0',
      },
      {
        label: 'Series B',
        data: values.map(v => v / 2),
        backgroundColor: 'rgba(153, 102, 255, 0.6)',
        stack: 'Stack 0',
      },
    ],
  };

  const options = {
    responsive: true,
    plugins: {
      legend: { position: 'top' },
    },
    scales: {
      x: { stacked: true },
      y: { stacked: true },
    },
  };

  return <Bar data={data} options={options} />;
};


// ✅ File: HistogramChart.jsx
import { Chart as ChartJS } from 'chart.js';
import { Bar } from 'react-chartjs-2';
import { HistogramController, Histogram } from 'chartjs-chart-histogram';

ChartJS.register(HistogramController, Histogram);

export const HistogramChart = ({ values }) => {
  const data = {
    labels: values,
    datasets: [
      {
        label: 'Histogram',
        data: values,
        bins: { start: 0, end: 100, count: 10 },
        backgroundColor: 'rgba(255, 99, 132, 0.5)',
      },
    ],
  };

  return <Bar data={data} options={{ responsive: true }} />;
};


// ✅ File: MapChart.jsx
import { ChoroplethChart, GeoFeature } from 'chartjs-chart-geo';
import { Chart as ChartJS } from 'chart.js';

ChartJS.register(ChoroplethChart, GeoFeature);

export const MapChart = ({ geoData }) => {
  if (!geoData) return <p>Loading geo data...</p>;

  const data = {
    labels: geoData.features.map(f => f.properties.name),
    datasets: [
      {
        label: 'Country Value',
        data: geoData.features.map(f => ({
          feature: f,
          value: Math.random() * 100,
        })),
      },
    ],
  };

  const options = {
    showOutline: true,
    showGraticule: true,
    plugins: {
      legend: { display: false },
      tooltip: {
        callbacks: {
          label: ctx => `${ctx.raw.feature.properties.name}: ${ctx.raw.value.toFixed(2)}`,
        },
      },
    },
  };

  return <ChoroplethChart data={data} options={options} />;
};
