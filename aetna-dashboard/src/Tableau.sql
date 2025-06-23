import React, { useState, useEffect } from 'react';
import { Collapse } from 'antd';

const { Panel } = Collapse;

const App = () => {
  const [arr, setArr] = useState(['Dog', 'Cat', 'Elephant']);
  const [activeKeys, setActiveKeys] = useState([]);

  // Prepare preprocessed items with keys and labels
  const panels = arr.map((val, index) => ({
    key: `panel-${index}`,
    header: `Panel ${index + 1}`,
    content: `${val} is an animal`
  }));

  // Only run when arr changes
  useEffect(() => {
    const lastKey = panels[panels.length - 1]?.key;
    setActiveKeys(lastKey ? [lastKey] : []);
  }, [arr]);

  const handleChange = (panelKey) => {
    setActiveKeys((prevKeys) =>
      prevKeys.includes(panelKey)
        ? prevKeys.filter((key) => key !== panelKey)
        : [...prevKeys, panelKey]
    );
  };

  return (
    <>
      {panels.map((panel) => (
        <Collapse
          key={panel.key}
          activeKey={activeKeys.includes(panel.key) ? [panel.key] : []}
          onChange={() => handleChange(panel.key)}
        >
          <Panel header={panel.header} key={panel.key}>
            <p>{panel.content}</p>
          </Panel>
        </Collapse>
      ))}
    </>
  );
};

export default App;
