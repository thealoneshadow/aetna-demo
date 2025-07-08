import { Bar } from 'react-chartjs-2';

export const HistogramChart = ({ values, binCount = 10 }) => {
  // 1. Compute min/max and bin width
  const min = Math.min(...values);
  const max = Math.max(...values);
  const binSize = (max - min) / binCount;

  const bins = new Array(binCount).fill(0);
  values.forEach(v => {
    const idx = Math.min(
      binCount - 1,
      Math.floor((v - min) / binSize)
    );
    bins[idx]++;
  });

  const labels = bins.map((_, i) => {
    const start = (min + i * binSize).toFixed(1);
    const end = (min + (i + 1) * binSize).toFixed(1);
    return `${start}–${end}`;
  });

  const data = {
    labels,
    datasets: [
      {
        label: 'Count',
        data: bins,
        backgroundColor: 'rgba(255, 99, 132, 0.5)',
      },
    ],
  };

  const options = { responsive: true };

  return <Bar data={data} options={options} />;
};
