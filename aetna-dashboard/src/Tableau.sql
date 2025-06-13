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














// components/TextSlider.jsx
import React, { useEffect, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

const sliderData = [
  {
    title: "Visualize Your Data",
    subtitle: "Use charts to make decisions easier and clearer."
  },
  {
    title: "Export in One Click",
    subtitle: "Download your charts as PDF or PNG instantly."
  },
  {
    title: "Dynamic Chart Viewer",
    subtitle: "Switch between multiple chart types with ease."
  }
];

export default function TextSlider() {
  const [currentIndex, setCurrentIndex] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentIndex((prev) => (prev + 1) % sliderData.length);
    }, 2000);
    return () => clearInterval(interval);
  }, []);

  const current = sliderData[currentIndex];

  return (
    <div style={{
      height: 80,
      textAlign: 'center',
      marginBottom: '30px',
      backgroundColor: '#f0f4f8',
      borderRadius: '12px',
      padding: '16px',
      overflow: 'hidden'
    }}>
      <AnimatePresence mode="wait">
        <motion.div
          key={currentIndex}
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: -10 }}
          transition={{ duration: 0.5 }}
        >
          <h2 style={{ margin: 0 }}>{current.title}</h2>
          <p style={{ margin: 0, fontSize: '14px', color: '#555' }}>
            {current.subtitle}
          </p>
        </motion.div>
      </AnimatePresence>
    </div>
  );
}
