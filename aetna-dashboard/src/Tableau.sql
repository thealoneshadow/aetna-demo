defaultValue={[dayjs('2015/01/01', dateFormat), dayjs('2015/01/01', dateFormat)]}

const currentDate = new Date();

// Get the date from exactly one week ago
const lastWeekDate = new Date();
lastWeekDate.setDate(currentDate.getDate() - 7);

// Format the dates as YYYY-MM-DD
const currentFormattedDate = currentDate.toISOString().slice(0, 10);
const lastWeekFormattedDate = lastWeekDate.toISOString().slice(0, 10);


import React from 'react';
import { Button, message, Space } from 'antd';

const App: React.FC = () => {
  const [messageApi, contextHolder] = message.useMessage();

  const success = () => {
    messageApi.open({
      type: 'success',
      content: 'This is a success message',
    });
  };

  const error = () => {
    messageApi.open({
      type: 'error',
      content: 'This is an error message',
    });
  };

  const warning = () => {
    messageApi.open({
      type: 'warning',
      content: 'This is a warning message',
    });
  };

  return (
    <>
      {contextHolder}
      <Space>
        <Button onClick={success}>Success</Button>
        <Button onClick={error}>Error</Button>
        <Button onClick={warning}>Warning</Button>
      </Space>
    </>
  );
};