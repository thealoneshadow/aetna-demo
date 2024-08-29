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





import React from 'react';
import ReactDOM from 'react-dom';
import './styles.css';

import { Sidenav, Nav } from 'rsuite';
import DashboardIcon from '@rsuite/icons/legacy/Dashboard';
import GroupIcon from '@rsuite/icons/legacy/Group';
import MagicIcon from '@rsuite/icons/legacy/Magic';
import GearCircleIcon from '@rsuite/icons/legacy/GearCircle';

const styles = {
  width: 240,
  position: 'absolute', // Position absolutely on the screen
  top: 0,
  left: 0,
  zIndex: 1000, // Make sure it is on top of other content
  display: 'inline-table',
  marginRight: 10,
  transition: 'transform 0.3s ease-in-out', // Smooth transition for showing/hiding
};

const CustomSidenav = ({ appearance, openKeys, expanded, onOpenChange, onExpand, ...navProps }) => {
  return (
    <div style={{ ...styles, transform: expanded ? 'translateX(0)' : 'translateX(-100%)' }}>
      <Sidenav
        appearance={appearance}
        expanded={expanded}
        openKeys={openKeys}
        onOpenChange={onOpenChange}
      >
        <Sidenav.Body>
          <Nav {...navProps}>
            <Nav.Item eventKey="1" active icon={<DashboardIcon />}>
              Dashboard
            </Nav.Item>
            <Nav.Item eventKey="2" icon={<GroupIcon />}>
              User Group
            </Nav.Item>
            <Nav.Menu eventKey="3" title="Advanced" icon={<MagicIcon />}>
              <Nav.Item eventKey="3-1">Geo</Nav.Item>
              <Nav.Item eventKey="3-2">Devices</Nav.Item>
              <Nav.Item eventKey="3-3">Loyalty</Nav.Item>
              <Nav.Item eventKey="3-4">Visit Depth</Nav.Item>
            </Nav.Menu>
            <Nav.Menu eventKey="4" title="Settings" icon={<GearCircleIcon />}>
              <Nav.Item eventKey="4-1">Applications</Nav.Item>
              <Nav.Item eventKey="4-2">Channels</Nav.Item>
              <Nav.Item eventKey="4-3">Versions</Nav.Item>
              <Nav.Menu eventKey="4-5" title="Custom Action">
                <Nav.Item eventKey="4-5-1">Action Name</Nav.Item>
                <Nav.Item eventKey="4-5-2">Action Params</Nav.Item>
              </Nav.Menu>
            </Nav.Menu>
          </Nav>
        </Sidenav.Body>
        <Sidenav.Toggle onToggle={onExpand} />
      </Sidenav>
    </div>
  );
};

const App = () => {
  const [activeKey, setActiveKey] = React.useState('1');
  const [openKeys, setOpenKeys] = React.useState(['3', '4']);
  const [expanded, setExpand] = React.useState(false); // Sidebar initially hidden

  return (
    <>
      {/* Sidebar Toggle Button */}
      <button
        style={{ position: 'fixed', top: 10, left: 10, zIndex: 1100 }}
        onClick={() => setExpand(!expanded)}
      >
        Toggle Sidebar
      </button>

      {/* Sidebar Components */}
      <CustomSidenav
        activeKey={activeKey}
        openKeys={openKeys}
        onSelect={setActiveKey}
        onOpenChange={setOpenKeys}
        expanded={expanded}
        onExpand={setExpand}
      />
      <CustomSidenav
        activeKey={activeKey}
        openKeys={openKeys}
        onOpenChange={setOpenKeys}
        onSelect={setActiveKey}
        expanded={expanded}
        onExpand={setExpand}
        appearance="inverse"
      />
      <CustomSidenav
        activeKey={activeKey}
        openKeys={openKeys}
        onOpenChange={setOpenKeys}
        onSelect={setActiveKey}
        expanded={expanded}
        onExpand={setExpand}
        appearance="subtle"
      />
    </>
  );
};


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


