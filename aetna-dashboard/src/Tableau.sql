// useFilteredGeoData.js
import { useEffect, useState } from "react";
import * as topojson from "topojson-client";

export const useFilteredGeoData = (mapGeoKeys = []) => {
  const [geoData, setGeoData] = useState(null);

  useEffect(() => {
    const fetchAndFilterGeoData = async () => {
      const res = await fetch("https://unpkg.com/world-atlas@2.0.2/countries-50m.json");
      const topo = await res.json();

      const fullGeoJSON = topojson.feature(topo, topo.objects.countries);

      // You will also need country names mapped
      const countryNames = await fetch(
        "https://unpkg.com/world-atlas@2.0.2/countries-50m.json"
      )
        .then((res) => res.json())
        .then((topo) => {
          return topo.objects.countries.geometries.map((g) => g.properties.name);
        });

      // Filter features based on passed keys
      const filtered = {
        ...fullGeoJSON,
        features: fullGeoJSON.features.filter((f) =>
          mapGeoKeys.includes(f.properties.name)
        ),
      };

      setGeoData(filtered);
    };

    fetchAndFilterGeoData();
  }, [mapGeoKeys]);

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
