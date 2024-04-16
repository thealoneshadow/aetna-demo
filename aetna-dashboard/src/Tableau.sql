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
  InsertUserId STRING(255) NOT NULL,
  UpdateUserId STRING(255),
  CreateDateTime TIMESTAMP NOT NULL,
  UpdateDateTime TIMESTAMP,
) PRIMARY KEY (Name);


CREATE TABLE DashboardFlow (
    Id STRING(255),
    Flow STRING(MAX),
    FlowNum INT64,
    InsertUserId STRING(MAX) NOT NULL,
    UpdateUserId STRING(MAX),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (Id);

CREATE TABLE DashboardKPIs (
    Id STRING(255),
    KPI STRING(255),
    Description STRING(MAX),
    KPINumber INT64,
    InsertUserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (Id);


CREATE TABLE ContentTable (
    ContentId STRING(255),
    TextId STRING(255),
    TextContent STRING(MAX),
    InsertUserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (ContentId);


CREATE TABLE ImageContent (
    ImageId STRING(255),
    ImageFieldId STRING(255),
    Image BLOB,
    ContentId STRING(255),
    InsertUserId STRING(255) NOT NULL,
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
    InsertUserId STRING(255) NOT NULL,
    UpdateUserId STRING(255),
    CreateDateTime TIMESTAMP NOT NULL,
    UpdateDateTime TIMESTAMP,
) PRIMARY KEY (ControlId);



