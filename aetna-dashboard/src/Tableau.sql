import React, { useState } from 'react';
import {
  DesktopOutlined,
  FileOutlined,
  PieChartOutlined,
  TeamOutlined,
  UserOutlined,
} from '@ant-design/icons';
import { Breadcrumb, Layout, Menu, theme } from 'antd';
const { Header, Content, Footer, Sider } = Layout;
function getItem(label, key, icon, children) {
  return {
    key,
    icon,
    children,
    label,
  };
}
const items = [
  getItem('Option 1', '1', <PieChartOutlined />),
  getItem('Option 2', '2', <DesktopOutlined />),
  getItem('User', 'sub1', <UserOutlined />, [
    getItem('Tom', '3'),
    getItem('Bill', '4'),
    getItem('Alex', '5'),
  ]),
  getItem('Team', 'sub2', <TeamOutlined />, [getItem('Team 1', '6'), getItem('Team 2', '8')]),
  getItem('Files', '9', <FileOutlined />),
];
const App = () => {
  const [collapsed, setCollapsed] = useState(false);
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();
  return (
    <Layout
      style={{
        minHeight: '100vh',
      }}
    >
      <Sider collapsible collapsed={collapsed} onCollapse={(value) => setCollapsed(value)}>
        <div className="demo-logo-vertical" />
        <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline" items={items} />
      </Sider>
      <Layout>
        <Header
          style={{
            padding: 0,
            background: colorBgContainer,
          }}
        />
        <Content
          style={{
            margin: '0 16px',
          }}
        >
          <Breadcrumb
            style={{
              margin: '16px 0',
            }}
          >
            <Breadcrumb.Item>User</Breadcrumb.Item>
            <Breadcrumb.Item>Bill</Breadcrumb.Item>
          </Breadcrumb>
          <div
            style={{
              padding: 24,
              minHeight: 360,
              background: colorBgContainer,
              borderRadius: borderRadiusLG,
            }}
          >
            Bill is a cat.
          </div>
        </Content>
        <Footer
          style={{
            textAlign: 'center',
          }}
        >
          Ant Design ©{new Date().getFullYear()} Created by Ant UED
        </Footer>
      </Layout>
    </Layout>
  );
};
export default App;




import React, { useEffect, useRef } from 'react';

const RStudioDashboard = () => {
  const iframeRef = useRef(null);

  useEffect(() => {
    // Function to handle click events within the iframe
    const handleIframeClick = (event) => {
      if (event.target.tagName === 'A' && event.target.href.includes('login')) {
        event.preventDefault();
        // Open the login in the same window or redirect the parent window
        window.location.href = event.target.href;
      }
    };

    // Check if iframe content is loaded and accessible
    const checkIframeContent = () => {
      try {
        const iframeDoc = iframeRef.current?.contentDocument || iframeRef.current?.contentWindow.document;
        if (iframeDoc) {
          iframeDoc.addEventListener('click', handleIframeClick);
        }
      } catch (error) {
        console.error('Cannot access iframe content due to cross-origin restrictions:', error);
      }
    };

    // Add an event listener to monitor iframe loading
    const iframe = iframeRef.current;
    iframe.addEventListener('load', checkIframeContent);

    // Cleanup function to remove event listeners
    return () => {
      iframe.removeEventListener('load', checkIframeContent);
      if (iframe.contentDocument) {
        iframe.contentDocument.removeEventListener('click', handleIframeClick);
      }
    };
  }, []);

  return (
    <iframe
      ref={iframeRef}
      src="https://your-rstudio-dashboard-url.com"
      title="RStudio Dashboard"
      style={{ width: '100%', height: '500px', border: 'none' }}
    />
  );
};

export default RStudioDashboard;
