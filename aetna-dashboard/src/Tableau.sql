import React from 'react';
import { Button, Tooltip } from 'antd';
const style = {
  width: '300vw',
  height: '300vh',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
};
const App = () => {
  React.useEffect(() => {
    document.documentElement.scrollTop = document.documentElement.clientHeight;
    document.documentElement.scrollLeft = document.documentElement.clientWidth;
  }, []);
  return (
    <div style={style}>
      <Tooltip title="Thanks for using antd. Have a nice day !" open>
        <Button type="primary">Scroll The Window</Button>
      </Tooltip>
    </div>
  );
};
export default App;


INSERT INTO userList (userId, userName, email)
SELECT 'new_user_id', 'New User', 'new.user@example.com'
WHERE NOT EXISTS (
    SELECT 1
    FROM userList
    WHERE email = 'new.user@example.com'
);