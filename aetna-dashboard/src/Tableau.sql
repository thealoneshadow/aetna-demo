import React, { useState, useEffect } from 'react';
import { Collapse } from 'antd';

const { Panel } = Collapse;

const App = () => {
  const [arr, setArr] = useState(['Dog', 'Cat', 'Elephant']);
  const [activeKeyList, setActiveKeyList] = useState([]);

  useEffect(() => {
    // Always keep only the last one open
    const newActiveKeyList = arr.map((_, i) => (i === arr.length - 1 ? `panel-${i}` : null)).filter(Boolean);
    setActiveKeyList(newActiveKeyList);
  }, [arr]);

  return (
    <>
      {arr.map((val, index) => (
        <Collapse
          key={index}
          activeKey={activeKeyList.includes(`panel-${index}`) ? [`panel-${index}`] : []}
          onChange={(keys) => {
            // Optional: Handle manual toggle if needed
            setActiveKeyList(keys);
          }}
        >
          <Panel header={`This is panel header ${index + 1}`} key={`panel-${index}`}>
            <p>{val} is an animal</p>
          </Panel>
        </Collapse>
      ))}
    </>
  );
};

export default App;
