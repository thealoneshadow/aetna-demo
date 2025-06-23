import React, { useEffect, useState } from 'react';
import { Collapse } from 'antd';

const { Panel } = Collapse;

const App = () => {
  const [chats, setChats] = useState([
    { id: 1, sender: 'User', message: 'Hi' },
    { id: 2, sender: 'Bot', message: 'Hello!' },
    { id: 3, sender: 'User', message: 'What’s up?' },
  ]);

  const [activeKeys, setActiveKeys] = useState([]);

  // Open only the last chat when chats change
  useEffect(() => {
    if (chats.length > 0) {
      const lastKey = chats[chats.length - 1].id.toString();
      setActiveKeys([lastKey]);
    }
  }, [chats]);

  const handleChange = (panelKey) => {
    setActiveKeys((prevKeys) =>
      prevKeys.includes(panelKey)
        ? prevKeys.filter((key) => key !== panelKey) // close
        : [...prevKeys, panelKey] // open
    );
  };

  return (
    <>
      {chats.map((chat) => (
        <Collapse
          key={chat.id}
          activeKey={activeKeys.includes(chat.id.toString()) ? [chat.id.toString()] : []}
          onChange={() => handleChange(chat.id.toString())}
        >
          <Panel header={`${chat.sender} said:`} key={chat.id.toString()}>
            <p>{chat.message}</p>
          </Panel>
        </Collapse>
      ))}
    </>
  );
};

export default App;
