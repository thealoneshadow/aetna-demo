// useFilteredGeoData.js
import { useEffect, useState } from 'react';
import * as topojson from 'topojson-client';

export const useChoroplethGeoData = ({ countryList = [], valueMap = {} }) => {
  const [geoData, setGeoData] = useState(null);

  useEffect(() => {
    const fetchGeoData = async () => {
      const topoRes = await fetch(
        'https://unpkg.com/world-atlas@2.0.2/countries-50m.json'
      );
      const topoJson = await topoRes.json();

      const worldGeo = topojson.feature(topoJson, topoJson.objects.countries);

      const filtered = {
        ...worldGeo,
        features: worldGeo.features
          .map((feature) => {
            const name = feature.properties.name;
            return {
              ...feature,
              properties: {
                ...feature.properties,
                value: valueMap[name] ?? 0,
              },
            };
          })
          .filter((f) => countryList.includes(f.properties.name)),
      };

      setGeoData(filtered);
    };

    fetchGeoData();
  }, [countryList, valueMap]);

  return geoData;
};



import { ChoroplethChart, GeoFeature } from 'chartjs-chart-geo';
import { Chart as ChartJS } from 'chart.js';

ChartJS.register(ChoroplethChart, GeoFeature);

export const MapChart = ({ geoData }) => {
  if (!geoData) return <p>Loading...</p>;

  const data = {
    labels: geoData.features.map(f => f.properties.name),
    datasets: [
      {
        label: 'Country Metric',
        data: geoData.features.map(f => ({
          feature: f,
          value: f.properties.value || 0,
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
          label: (ctx) =>
            `${ctx.raw.feature.properties.name}: ${ctx.raw.value.toFixed(2)}`,
        },
      },
    },
  };

  return <ChoroplethChart data={data} options={options} />;
};




import { useChoroplethGeoData } from './useChoroplethGeoData';
import { MapChart } from './MapChart';

const countryList = ['India', 'United States', 'Germany'];
const valueMap = {
  India: 120,
  'United States': 300,
  Germany: 180,
};

export const App = () => {
  const geoData = useChoroplethGeoData({ countryList, valueMap });

  return <MapChart geoData={geoData} />;
};




geoData.features = geoData.features.map((f) => ({
  ...f,
  properties: {
    ...f.properties,
    value: yourDataMap[f.properties.name] || 0
  }
}));
