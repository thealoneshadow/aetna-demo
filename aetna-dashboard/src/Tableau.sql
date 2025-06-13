import React from 'react';
import { Slider } from 'antd';

const onChange = (value) => {
  console.log('onChange: ', value);
};

const onChangeComplete = (value) => {
  console.log('onChangeComplete: ', value);
};

const App = () => (
  <>
    <h3>Single Value Slider</h3>
    <Slider
      min={10}
      max={10000}
      defaultValue={100}
      step={10}
      onChange={onChange}
      onChangeComplete={onChangeComplete}
    />

    <h3>Range Slider</h3>
    <Slider
      range
      min={10}
      max={10000}
      step={10}
      defaultValue={[100, 1000]}
      onChange={onChange}
      onChangeComplete={onChangeComplete}
    />
  </>
);

export default App;
