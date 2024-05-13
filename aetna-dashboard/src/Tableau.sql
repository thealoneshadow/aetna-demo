CREATE TABLE DashboardInfoTable (
  DashboardId STRING(255),
  Name STRING(255),
  Description STRING(MAX),
  LastRefreshDate STRING(MAX),
  RefreshFrequency STRING(MAX),
  URL STRING(MAX),
  Usecase STRING(MAX),
  Path STRING(MAX),
  Disabled BOOLEAN,
  UserId STRING(255) NOT NULL,
  UpdateUserId STRING(255),
  CreateDateTime TIMESTAMP NOT NULL,
  UpdateDateTime TIMESTAMP
) PRIMARY KEY (Name);

CREATE TABLE KPI (
  KPIId STRING(255),
  DashboardId STRING(255),
  Name STRING(255),
  Description STRING(MAX)
) PRIMARY KEY (KPIId);

CREATE TABLE Dimension (
  DimensionId STRING(255),
  DashboardId STRING(255),
  Name STRING(255),
  Description STRING(MAX)
) PRIMARY KEY (DimensionId);


CREATE TABLE ContentTable (
    ContentId STRING(255),
    TextId STRING(255),
    TextContent STRING(MAX),
    ContentImage STRING(MAX),
    ContentDate STRING(MAX),
    ContentOwnerName STRING(MAX),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (ContentId);

CREATE TABLE SubContentTable (
    SubContentId STRING(255),
    ContentId STRING(255),
    TextId STRING(255),
    TextContent STRING(MAX),
    ContentImage STRING(MAX),
    ContentDate STRING(MAX),
    ContentOwnerName STRING(MAX),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (SubContentId);

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

CREATE TABLE DashboardHistory (
    DashboardId STRING(255),
    Name STRING(255),
    Description STRING(MAX),
    LastRefreshDate STRING(MAX),
    RefreshFrequency STRING(MAX),
    URL STRING(MAX),
    Usecase STRING(MAX),
    Path STRING(MAX),
    Disabled BOOLEAN,
    UserId STRING(MAX) NOT NULL,
    CreateDateTime TIMESTAMP NOT NULL,
    DeletedDateTime TIMESTAMP NOT NULL,
) PRIMARY KEY (Id);


CREATE TABLE ContentHistoryTable (
    ContentId STRING(255),
    TextId STRING(255),
    TextContent STRING(MAX),
    ContentImage STRING(MAX),
    ContentDate STRING(MAX),
    ContentOwnerName STRING(MAX),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE SubContentHistoryTable (
    SubContentId STRING(255),
    ContentId STRING(255),
    TextId STRING(255),
    TextContent STRING(MAX),
    ContentImage STRING(MAX),
    ContentDate STRING(MAX),
    ContentOwnerName STRING(MAX),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (SubContentId);


CREATE TABLE Folders (
    FolderId STRING(255),
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

CREATE TABLE FavouriteDashboardsHistory (
    FavouriteDashboardId STRING(255),
    Name STRING(255),
    URL STRING(MAX),
    FolderId STRING(255),
    UserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (FavouriteDashboardId);

CREATE TABLE UserDetails (
    UserId STRING(255),
    Name STRING(255),
    Role STRING(MAX),
    VerticalsAllowed STRING(255),
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (FavouriteDashboardId);

CREATE TABLE Vertical (
    VerticalId STRING(255),
    Name STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (FavouriteDashboardId); 

-- For verticals Table Garima want to change name of vertical in future

