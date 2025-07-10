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



import { MapChart } from './MapChart';
import { useFilteredGeoData } from './useFilteredGeoData';

const YourComponent = () => {
  const mapGeoKeys = ['India', 'United States']; // from AI response
  const geoData = useFilteredGeoData(mapGeoKeys);

  return <MapChart geoData={geoData} />;
};


geoData.features = geoData.features.map((f) => ({
  ...f,
  properties: {
    ...f.properties,
    value: yourDataMap[f.properties.name] || 0
  }
}));
