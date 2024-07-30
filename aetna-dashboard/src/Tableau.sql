import { Bar } from "react-chartjs-2";
export const BarChart = ({ chartData }) => {
  return (
    <div className="chart-container">
      <h2 style={{ textAlign: "center" }}>Bar Chart</h2>
      <Bar
        data={chartData}
        options={{
          plugins: {
            title: {
              display: true,
              text: "Users Gained between 2016-2020"
            },
            legend: {
              display: false
            }
          }
        }}
      />
    </div>
  );
};

import Chart from "chart.js/auto";
import { CategoryScale } from "chart.js";
import { useState } from "react";
import { Data } from "./Data";
import PieChart from "../components/PieChart";
import BarChart from "../components/BarChart";
import "./styles.css";

Chart.register(CategoryScale);


 labels: Data.map((data) => data.year), 
    datasets: [
      {
        label: "Users Gained ",
        data: Data.map((data) => data.userGain),
        backgroundColor: [
          "rgba(75,192,192,1)",
          &quot;#ecf0f1",
          "#50AF95",
          "#f3ba2f",
          "#2a71d0"
        ],
        borderColor: "black",
      

 
  /* Hide x-axis labels */
  .chartjs-render-monitor .chartjs-chart-x-axis {
    display: none;
  }

  /* Hide y-axis labels */
  .chartjs-render-monitor .chartjs-chart-y-axis {
    display: none;
  }


 scales: {
     yAxes: [{
         ticks: {
            display: false
          }
      }]
  }