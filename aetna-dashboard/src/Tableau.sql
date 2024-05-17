CREATE TABLE DashboardInfoTable (
  DashboardId STRING(255),
  Name STRING(255),
  Description STRING(MAX),
  LastRefreshDate STRING(MAX),
  RefreshFrequency STRING(MAX),
  URL STRING(MAX),
  Usecase STRING(MAX),
  Path STRING(MAX),
  Disabled BOOL,
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
    Disabled BOOL,
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


DROP TABLE Vertical;
DROP TABLE UserDetails;
DROP TABLE FavouriteDashboardsHistory;
DROP TABLE FavouriteDashboards;
DROP TABLE Folders;
DROP TABLE SubContentHistoryTable;
DROP TABLE ContentHistoryTable;
DROP TABLE DashboardHistory;
DROP TABLE ImageContent;
DROP TABLE SubContentTable;
DROP TABLE ContentTable;
DROP TABLE Dimension;
DROP TABLE KPI;
DROP TABLE DashboardInfoTable;


-- Insert into DashboardInfoTable
INSERT INTO DashboardInfoTable (DashboardId, Name, Description, LastRefreshDate, RefreshFrequency, URL, Usecase, Path, Disabled, UserId, UpdateUserId, CreateDateTime, UpdateDateTime)
VALUES ('D1', 'Dashboard1', 'This is a description', '2022-01-01', 'Daily', 'http://example.com', 'Use case 1', '/path/to/dashboard', FALSE, 'User1', 'User2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert into KPI
INSERT INTO KPI (KPIId, DashboardId, Name, Description)
VALUES ('K1', 'D1', 'KPI1', 'This is a KPI description');

-- Insert into Dimension
INSERT INTO Dimension (DimensionId, DashboardId, Name, Description)
VALUES ('Dim1', 'D1', 'Dimension1', 'This is a dimension description');

-- Similarly, you can create INSERT statements for other tables.

