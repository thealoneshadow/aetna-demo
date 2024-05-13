CREATE TABLE DashboardInfoTable (
  DashboardId STRING(255),
  Name STRING(255),
  Description STRING(MAX),
  Use STRING(MAX),
  Impact STRING(MAX),
  URL STRING(MAX),
  UserBase STRING(MAX),
  KPI ARRAY<STRUCT<Key STRING(255), Value STRING(MAX)>>,
  Path STRING(MAX),
  UserId STRING(255) NOT NULL,
  UpdateUserId STRING(255),
  CreateDateTime TIMESTAMP NOT NULL,
  UpdateDateTime TIMESTAMP,
) PRIMARY KEY (Name);


CREATE TABLE DashboardFlow (
    Id STRING(255),
    Flow STRING(MAX),
    FlowNum INT64,
    UserId STRING(MAX) NOT NULL,
    UpdateUserId STRING(MAX),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (Id);

CREATE TABLE DashboardKPIs (
    Id STRING(255),
    KPI STRING(255),
    Description STRING(MAX),
    KPINumber INT64,
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (Id);


CREATE TABLE ContentTable (
    ContentId STRING(255),
    TextId STRING(255),
    TextContent STRING(MAX),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (ContentId);


CREATE TABLE ImageContent (
    ImageId STRING(255),
    ImageFieldId STRING(255),
    Image BLOB,
    ContentId STRING(255),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (ImageId);


CREATE TABLE Controls (
    ControlId STRING(MAX),
    ControlType STRING(MAX),
    Header STRING(MAX),
    TextContentId STRING(255),
    ImageContentId STRING(255),
    ParentControlId STRING(255),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (ControlId);


CREATE TABLE DashboardHistory (
    DashboardId STRING(255),
    Name STRING(255),
    Description STRING(MAX),
    Use STRING(MAX),
    Impact STRING(MAX),
    URL STRING(MAX),
    UserBase STRING(MAX),
    KPI ARRAY<STRUCT<Key STRING(255), Value STRING(MAX)>>,
    Path STRING(MAX),
    UserId STRING(MAX) NOT NULL,
    CreateDateTime TIMESTAMP NOT NULL,
    DeletedDateTime TIMESTAMP NOT NULL,
) PRIMARY KEY (Id);


CREATE TABLE ContentHistory (
    ContentId STRING(255),
    TextId STRING(255),
    TextContent STRING(MAX),
    ImageId STRING(255),
    ImageFieldId STRING(255),
    Image BLOB,
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (id);


CREATE TABLE Folders (
    FolderId STRING(255),
    DashboardIds ARRAY<STRING(255)>,
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (FolderId);

CREATE TABLE FavouriteDashboards (
    FavouriteDashboardId STRING(255),
    Name STRING(255),
    URL STRING(MAX),
    FolderId STRING(255),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (FavouriteDashboardId);


const axios = require('axios');
const qs = require('querystring');

async function getToken() {
  const tokenEndpoint = 'https://example.com/oauth/token'; // Replace with your token endpoint
  const clientId = 'your_client_id'; // Replace with your client ID
  const clientSecret = 'your_client_secret'; // Replace with your client secret

  const config = {
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    auth: {
      username: clientId,
      password: clientSecret
    }
  };

  const data = qs.stringify({
    grant_type: 'client_credentials'
  });

  try {
    const response = await axios.post(tokenEndpoint, data, config);
    return response.data.access_token;
  } catch (error) {
    console.error('Error getting token:', error);
  }
}

getToken().then(token => console.log('Token:', token));

