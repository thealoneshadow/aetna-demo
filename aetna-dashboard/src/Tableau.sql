import React, { useEffect, useState } from 'react';
import { Collapse } from 'antd';

const Demo = ({ data }) => {
  const [activeKeys, setActiveKeys] = useState({}); // store activeKey for each index

  useEffect(() => {
    // On data change, only open the 2nd panel (key = '2') of the last Collapse
    const newActiveKeys = {};
    const lastIndex = data.length - 1;
    newActiveKeys[lastIndex] = ['2'];
    setActiveKeys(newActiveKeys);
  }, [data]);

  const handleChange = (index) => (keys) => {
    setActiveKeys((prev) => ({
      ...prev,
      [index]: keys, // allow user to interact per collapse
    }));
  };

  return (
    <div>
      {data.map((item, index) => {
        const items = [
          {
            key: '1',
            label: `Panel 1 of item ${index + 1}`,
            children: `This is the first panel of item ${index + 1}`,
          },
          {
            key: '2',
            label: `Panel 2 of item ${index + 1}`,
            children: `This is the second panel of item ${index + 1}`,
          },
        ];

        return (
          <Collapse
            key={index}
            items={items}
            activeKey={activeKeys[index] || []}
            onChange={handleChange(index)}
          />
        );
      })}
    </div>
  );
};
