import React from 'react';
import { DatePicker, Space } from 'antd';
import moment from 'moment';

const onChange = (date, dateString) => {
  console.log(date, dateString);
};

// Function to disable dates based on the current date
const disabledDate = (current) => {
  const today = moment();
  const currentYear = today.year();
  const cutoffDate = moment(`${currentYear}-10-01`); // October 1st of the current year

  // If today is after October 1st, disable current year
  if (today.isAfter(cutoffDate)) {
    return current && current.year() < currentYear; // Allow only years greater than or equal to the current year
  }

  // If today is before October 1st, allow current year and beyond
  return current && current.year() < currentYear - 1; // Disable years less than the previous year
};

const App = () => (
  <Space direction="vertical">
    {/* Set disabledDate to dynamically control the year selection */}
    <DatePicker onChange={onChange} picker="year" disabledDate={disabledDate} />
  </Space>
);

export default App;



import React, { useState } from 'react';
import { spfi, SPFx } from "@pnp/sp";
import "@pnp/sp/files";
import "@pnp/sp/webs";

// Function to get an OAuth token (replace with your actual logic)
const getToken = async () => "your-oauth-token";

const SharePointDocumentDownloader = ({ fileUrl }) => {
  const [loading, setLoading] = useState(false);

  const initializePnPjs = async () => {
    const token = await getToken();

    const sp = spfi().using(SPFx({
      headers: {
        "Accept": "application/json;odata=verbose",
        "Authorization": `Bearer ${token}`,
      },
    }));

    return sp;
  };

  const downloadFile = async () => {
    setLoading(true);
    const sp = await initializePnPjs();

    try {
      const file = await sp.web.getFileByServerRelativeUrl(fileUrl).getBlob();
      const url = window.URL.createObjectURL(file);
      const a = document.createElement('a');
      a.href = url;
      a.download = fileUrl.split('/').pop(); // Extract file name from URL
      document.body.appendChild(a);
      a.click();
      a.remove();
    } catch (error) {
      console.error("Error downloading file:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <button onClick={downloadFile} disabled={loading}>
        {loading ? "Downloading..." : "Download File"}
      </button>
    </div>
  );
};

export default SharePointDocumentDownloader;


