import React, { useState, useEffect } from 'react';
import { Collapse } from 'antd';

const { Panel } = Collapse;

const App = () => {
  const [arr, setArr] = useState(['Dog', 'Cat', 'Elephant']);
  const [activeKeys, setActiveKeys] = useState([]);

  // When array changes, open only the last
  useEffect(() => {
    const lastKey = `panel-${arr.length - 1}`;
    setActiveKeys([lastKey]);
  }, [arr]);

  const handleChange = (key, index) => {
    setActiveKeys((prevKeys) => {
      const panelKey = `panel-${index}`;
      if (prevKeys.includes(panelKey)) {
        return prevKeys.filter(k => k !== panelKey); // close
      } else {
        return [...prevKeys, panelKey]; // open
      }
    });
  };

  return (
    <>
      {arr.map((val, index) => {
        const panelKey = `panel-${index}`;
        return (
          <Collapse
            key={panelKey}
            activeKey={activeKeys.includes(panelKey) ? [panelKey] : []}
            onChange={() => handleChange(panelKey, index)}
          >
            <Panel header={`Panel ${index + 1}`} key={panelKey}>
              <p>{val} is an animal</p>
            </Panel>
          </Collapse>
        );
      })}
    </>
  );
};

export default App;
