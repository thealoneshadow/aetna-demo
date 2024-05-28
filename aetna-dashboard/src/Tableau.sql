CREATE TABLE dashboardInfoTable (
  id STRING(255),
  name STRING(255),
  description STRING(MAX),
  lastRefreshDate STRING(MAX),
  refreshFrequency STRING(MAX),
  url STRING(MAX),
  usecase STRING(MAX),
  path STRING(MAX),
  disabled BOOL,
  created_user STRING(255) NOT NULL,
  updated_user STRING(255),
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP
) PRIMARY KEY (id);

CREATE TABLE kpi (
  id STRING(255),
  dashboardId STRING(255),
  name STRING(255),
  description STRING(MAX),
  created_user STRING(255) NOT NULL,
  updated_user STRING(255),
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP
) PRIMARY KEY (id);

CREATE TABLE dimension (
  id STRING(255),
  dashboardId STRING(255),
  name STRING(255),
  description STRING(MAX)
) PRIMARY KEY (id);


CREATE TABLE contentTable (
    id STRING(255),
    textId STRING(255),
    textContent STRING(MAX),
    contentImage STRING(MAX),
    contentDate STRING(MAX),
    contentOwnername STRING(MAX),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE subContentTable (
    id STRING(255),
    contentId STRING(255),
    textId STRING(255),
    textContent STRING(MAX),
    contentImage STRING(MAX),
    contentDate STRING(MAX),
    contentOwnername STRING(MAX),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE imageContent (
    id STRING(255),
    imageFieldId STRING(255),
    image BLOB,
    contentId STRING(255),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE dashboardHistory (
    id STRING(255),
    name STRING(255),
    description STRING(MAX),
    lastRefreshDate STRING(MAX),
    refreshFrequency STRING(MAX),
    url STRING(MAX),
    usecase STRING(MAX),
    path STRING(MAX),
    disabled BOOL,
    created_user STRING(MAX) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    deletedDateTime TIMESTAMP NOT NULL,
) PRIMARY KEY (id);


CREATE TABLE contentHistoryTable (
    id STRING(255),
    textId STRING(255),
    textContent STRING(MAX),
    contentImage STRING(MAX),
    contentDate STRING(MAX),
    contentOwnername STRING(MAX),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE subContentHistoryTable (
    id STRING(255),
    contentId STRING(255),
    textId STRING(255),
    textContent STRING(MAX),
    contentImage STRING(MAX),
    contentDate STRING(MAX),
    contentOwnername STRING(MAX),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (SubContentId);


CREATE TABLE folders (
    id STRING(255),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE favouriteDashboards (
    id STRING(255),
    name STRING(255),
    url STRING(MAX),
    folderId STRING(255),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE favouriteDashboardsHistory (
    id STRING(255),
    name STRING(255),
    url STRING(MAX),
    folderId STRING(255),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE userDetails (
    created_user STRING(255),
    name STRING(255),
    Role STRING(MAX),
    VerticalsAllowed STRING(255),
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (FavouriteDashboardId);

CREATE TABLE vertical (
    id STRING(255),
    name STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id); 

CREATE TABLE seeMorePage (
    id STRING(255),
    heading STRING(255),
    vertical STRING(255),
    description STRING(MAX),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE seeMorePageSubContent (
    id STRING(255),
    heading STRING(255),
    seeMorePageId STRING(255),
    url STRING(max),
    description STRING(MAX),
    owner STRING(255),
    date STRING(255),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE seeMorePageHistory (
    id STRING(255),
    heading STRING(255),
    vertical STRING(255),
    description STRING(MAX),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);

CREATE TABLE seeMorePageSubContentHistory (
    id STRING(255),
    heading STRING(255),
    seeMorePageId STRING(255),
    url STRING(max),
    description STRING(MAX),
    owner STRING(255),
    date STRING(255),
    created_user STRING(255) NOT NULL,
    updated_user STRING(255),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
) PRIMARY KEY (id);


-- For verticals Table Garima want to change name of vertical in future


DROP TABLE vertical;
DROP TABLE userDetails;
DROP TABLE favouriteDashboardsHistory;
DROP TABLE favouriteDashboards;
DROP TABLE folders;
DROP TABLE subContentHistoryTable;
DROP TABLE contentHistoryTable;
DROP TABLE dashboardHistory;
DROP TABLE imageContent;
DROP TABLE subContentTable;
DROP TABLE contentTable;
DROP TABLE dimension;
DROP TABLE kpi;
DROP TABLE dashboardInfoTable;
DROP TABLE seeMorePage;
DROP TABLE seeMorePageHistory;
DROP TABLE seeMorePageSubContent;
DROP TABLE seeMorePageSubContentHistory;

-- Insert into dashboardInfoTable
INSERT INTO dashboardInfoTable (
    id, name, description, lastRefreshDate, refreshFrequency, url, usecase, path, disabled, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'Sales Dashboard', 'Dashboard for sales metrics', '2024-05-20', 'Daily', 'http://example.com/sales', 'Sales Analysis', '/dashboards/sales', false, 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into kpi
INSERT INTO kpi (
    id, dashboardId, name, description, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', '1', 'Total Sales', 'Total sales over time', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into dimension
INSERT INTO dimension (
    id, dashboardId, name, description
) VALUES (
    '1', '1', 'Region', 'Geographical regions'
);

-- Insert into contentTable
INSERT INTO contentTable (
    id, textId, textContent, contentImage, contentDate, contentOwnername, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'txt001', 'Sample text content', 'image.png', '2024-05-20', 'John Doe', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into subContentTable
INSERT INTO subContentTable (
    id, contentId, textId, textContent, contentImage, contentDate, contentOwnername, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', '1', 'txt002', 'Sub content text', 'subimage.png', '2024-05-20', 'Jane Doe', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into imageContent
INSERT INTO imageContent (
    id, imageFieldId, image, contentId, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'img001', 'sample_image_blob_data', '1', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into dashboardHistory
INSERT INTO dashboardHistory (
    id, name, description, lastRefreshDate, refreshFrequency, url, usecase, path, disabled, created_user, created_at, deletedDateTime
) VALUES (
    '1', 'Sales Dashboard', 'Historical record of sales dashboard', '2024-05-19', 'Daily', 'http://example.com/sales', 'Sales Analysis', '/dashboards/sales', false, 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into contentHistoryTable
INSERT INTO contentHistoryTable (
    id, textId, textContent, contentImage, contentDate, contentOwnername, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'txt001', 'Historical text content', 'hist_image.png', '2024-05-19', 'John Doe', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into subContentHistoryTable
INSERT INTO subContentHistoryTable (
    id, contentId, textId, textContent, contentImage, contentDate, contentOwnername, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', '1', 'txt002', 'Historical sub content', 'hist_subimage.png', '2024-05-19', 'Jane Doe', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into folders
INSERT INTO folders (
    id, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into favouriteDashboards
INSERT INTO favouriteDashboards (
    id, name, url, folderId, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'Favourite Sales Dashboard', 'http://example.com/sales', '1', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into favouriteDashboardsHistory
INSERT INTO favouriteDashboardsHistory (
    id, name, url, folderId, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'Favourite Sales Dashboard', 'http://example.com/sales', '1', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into userDetails
INSERT INTO userDetails (
    created_user, name, Role, VerticalsAllowed, updated_user, created_at, updated_at
) VALUES (
    'admin', 'Admin User', 'Administrator', 'All', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into vertical
INSERT INTO vertical (
    id, name, created_at, updated_at
) VALUES (
    '1', 'Sales', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into seeMorePage
INSERT INTO seeMorePage (
    id, heading, vertical, description, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'More on Sales', 'Sales', 'Detailed sales information', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into seeMorePageSubContent
INSERT INTO seeMorePageSubContent (
    id, heading, seeMorePageId, url, description, owner, date, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'Sales Detail', '1', 'http://example.com/details', 'In-depth sales detail', 'John Doe', '2024-05-20', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into seeMorePageHistory
INSERT INTO seeMorePageHistory (
    id, heading, vertical, description, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'More on Sales', 'Sales', 'Historical sales information', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

-- Insert into seeMorePageSubContentHistory
INSERT INTO seeMorePageSubContentHistory (
    id, heading, seeMorePageId, url, description, owner, date, created_user, updated_user, created_at, updated_at
) VALUES (
    '1', 'Sales Detail', '1', 'http://example.com/details', 'Historical in-depth sales detail', 'John Doe', '2024-05-19', 'admin', 'admin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);





import React, { useState } from 'react';
import './CardList.css'; // Assuming you create and import this CSS file

const CardList = () => {
  const [names, setNames] = useState(['Name 1', 'Name 2', 'Name 3', 'Name 4']);
  const [descriptions, setDescriptions] = useState(['Description 1', 'Description 2', 'Description 3', 'Description 4']);

  return (
    <div className="card-list-container">
      {names.map((name, index) => (
        <div key={index} className="card">
          <div className="name">{name}</div>
          <div className="description">{descriptions[index]}</div>
          {names[index + names.length / 2] && (
            <>
              <div className="name">{names[index + names.length / 2]}</div>
              <div className="description">{descriptions[index + descriptions.length / 2]}</div>
            </>
          )}
        </div>
      ))}
    </div>
  );
};

export default CardList;


.card-list-container {
  display: flex;
  justify-content: center;
  padding: 20px;
}

.card {
  display: flex;
  flex-wrap: wrap;
  border: 1px solid #ddd;
  border-radius: 20px;
  padding: 20px;
  max-width: 80%;
}

.name, .description {
  margin-right: 20px;
  margin-bottom: 10px;
  white-space: nowrap;
}

.card > .name, .card > .description {
  flex: 1 1 auto;
}

.card > .name:last-of-type, .card > .description:last-of-type {
  margin-right: 0;
}


