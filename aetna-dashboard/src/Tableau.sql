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


let result = originalData.reduce((acc, curr) => {
  let vertical = {};
  curr.data.forEach((item) => {
    let temp = vertical;
    for (let i = 0; i < item.path.length; i++) {
      if (!temp[item.path[i]]) {
        temp[item.path[i]] = {};
      }
      if (i === item.path.length - 1) {
        // if this path already exists and it's the last element, combine the dashboardInfos
        if (temp[item.path[i]].dashboardInfo) {
          if (Array.isArray(temp[item.path[i]].dashboardInfo)) {
            temp[item.path[i]].dashboardInfo.push(item.dashboardInfo);
          } else {
            temp[item.path[i]].dashboardInfo = [temp[item.path[i]].dashboardInfo, item.dashboardInfo];
          }
        } else {
          temp[item.path[i]].dashboardInfo = [item.dashboardInfo];
        }
      }
      temp = temp[item.path[i]];
    }
  });
  acc[curr.vertical] = vertical;
  return acc;
}, {});

console.log(result);