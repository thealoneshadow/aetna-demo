import React, { useState } from 'react';
import { Slider, InputNumber } from 'antd';

const App = () => {
  const [singleValue, setSingleValue] = useState(100);
  const [rangeValue, setRangeValue] = useState([100, 1000]);

  return (
    <div style={{ width: 500, margin: '2rem auto' }}>
      <h3>Single Value Slider: {singleValue}</h3>
      <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
        <Slider
          min={10}
          max={10000}
          step={10}
          value={singleValue}
          onChange={setSingleValue}
          style={{ flex: 1 }}
        />
        <InputNumber
          min={10}
          max={10000}
          step={10}
          value={singleValue}
          onChange={(val) => setSingleValue(val ?? 10)}
        />
      </div>

      <h3 style={{ marginTop: '2rem' }}>
        Range Slider: {rangeValue[0]} - {rangeValue[1]}
      </h3>
      <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
        <Slider
          range
          min={10}
          max={10000}
          step={10}
          value={rangeValue}
          onChange={setRangeValue}
          style={{ flex: 1 }}
        />
        <InputNumber
          min={10}
          max={10000}
          step={10}
          value={rangeValue[0]}
          onChange={(val) =>
            setRangeValue([val ?? 10, rangeValue[1]])
          }
        />
        <InputNumber
          min={10}
          max={10000}
          step={10}
          value={rangeValue[1]}
          onChange={(val) =>
            setRangeValue([rangeValue[0], val ?? 10])
          }
        />
      </div>
    </div>
  );
};

export default App;
