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




const axios = require('axios');
const qs = require('qs');

const tokenUrl = "<Your Token URL>";
const clientSecret = "<Your Client Secret>";
const grantType = "authorization_code";
const code = "<The Authorization Code You Received>";

let data = qs.stringify({
  'grant_type': grantType,
  'client_id': clientId,
  'client_secret': clientSecret,
  'redirect_uri': callbackUrl,
  'code': code
});

let config = {
  method: 'post',
  url: tokenUrl,
  headers: { 
    'Content-Type': 'application/x-www-form-urlencoded'
  },
  data : data
};

axios(config)
.then(function (response) {
  console.log(JSON.stringify(response.data));
})
.catch(function (error) {
  console.log(error);
});

.tooltip {
  position: absolute;
  background-color: #555;
  color: #fff;
  text-align: center;
  padding: 5px;
  border-radius: 6px;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  opacity: 0;
  transition: opacity 0.3s;
}

.tooltip.show {
  opacity: 1;
}

def upload_image():
    # Get the image file from the form data
    image_file = request.files['image']

    # Read the image file as bytes
    image_bytes = image_file.read()

    # Convert the image bytes to base64
    image_base64 = base64.b64encode(image_bytes)

    # Instantiate a Spanner client
    spanner_client = spanner.Client()

    # Get a Spanner instance by ID
    instance = spanner_client.instance('my-instance')

    # Get a Spanner database by ID
    database = instance.database('my-database')

    # SQL statement to insert the image
    sql = "INSERT INTO my-table (id, image) VALUES (@id, @image)"

    # Parameters for the SQL statement
    params = {"id": "your-id", "image": image_base64}




    # Run the transaction
    database.run_in_transaction(lambda transaction: transaction.execute_update(sql, params=params))

    return 'Image uploaded successfully', 200


    spanner_client = spanner.Client()

    # Get a Spanner instance by ID
    instance = spanner_client.instance('my-instance')

    # Get a Spanner database by ID
    database = instance.database('my-database')

    # SQL statement to select the image
    sql = "SELECT image FROM my-table WHERE id = @id"

    # Parameters for the SQL statement
    params = {"id": "your-id"}

    # Run the transaction and get the image
    image_base64 = database.run_in_transaction(lambda transaction: transaction.execute_sql(sql, params=params).one()[0])

    # Convert the base64 BLOB back to bytes
    image_bytes = base64.b64decode(image_base64)

    # Return the image bytes as a response
    return image_bytes, 200, {'Content-Type': 'image/jpeg'}

    function transformData(fields, data) {
    // Initialize an empty array to hold the transformed data
    const result = [];
    
    // Iterate over each row in the data array
    data.forEach(row => {
        // Initialize an empty object to hold the row data
        const obj = {};
        
        // Iterate over each field and assign the corresponding data value to the object
        fields.forEach((field, index) => {
            // Remove backslashes from the data if necessary and assign to the object
            obj[field] = row[index].replace(/\\/g, '');
        });
        
        // Push the object to the result array
        result.push(obj);
    });
    
    return result;
}

 const [searchText, setSearchText] = useState('');
  const [searchedColumn, setSearchedColumn] = useState('');
  const searchInput = useRef(null);

  // State and refs for the second table
  const [dashSearchText, setDashSearchText] = useState('');
  const [searchedDashColumn, setSearchedDashColumn] = useState('');
  const dashSearchInput = useRef(null);

  // Search functions for the first table
  const handleSearch = (selectedKeys, confirm, dataIndex) => {
    confirm();
    setSearchText(selectedKeys[0]);
    setSearchedColumn(dataIndex);
  };

  const handleReset = clearFilters => {
    clearFilters();
    setSearchText('');
  };

  const getColumnSearchProps = dataIndex => ({
    filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters }) => (
      <div style={{ padding: 8 }}>
        <Input
          ref={searchInput}
          placeholder={`Search ${dataIndex}`}
          value={selectedKeys[0]}
          onChange={e => setSelectedKeys(e.target.value ? [e.target.value] : [])}
          onPressEnter={() => handleSearch(selectedKeys, confirm, dataIndex)}
          style={{ marginBottom: 8, display: 'block' }}
        />
        <Space>
          <Button
            type="primary"
            onClick={() => handleSearch(selectedKeys, confirm, dataIndex)}
            icon={<SearchOutlined />}
            size="small"
            style={{ width: 90 }}
          >
            Search
          </Button>
          <Button onClick={() => handleReset(clearFilters)} size="small" style={{ width: 90 }}>
            Reset
          </Button>
        </Space>
      </div>
    ),
    filterIcon: filtered => <SearchOutlined style={{ color: filtered ? '#1890ff' : undefined }} />,
    onFilter: (value, record) =>
      record[dataIndex]
        ? record[dataIndex].toString().toLowerCase().includes(value.toLowerCase())
        : '',
    onFilterDropdownVisibleChange: visible => {
      if (visible) {
        setTimeout(() => searchInput.current?.select(), 100);
      }
    },
    render: text =>
      searchedColumn === dataIndex ? (
        <Highlighter
          highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
          searchWords={[searchText]}
          autoEscape
          textToHighlight={text ? text.toString() : ''}
        />
      ) : (
        text
      ),
  });

  // Search functions for the second table
  const handleDashSearch = (selectedKeys, confirm, dataIndex) => {
    confirm();
    setDashSearchText(selectedKeys[0]);
    setSearchedDashColumn(dataIndex);
  };

  const handleDashReset = clearFilters => {
    clearFilters();
    setDashSearchText('');
  };

  const getDashColumnSearchProps = dataIndex => ({
    filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters }) => (
      <div style={{ padding: 8 }}>
        <Input
          ref={dashSearchInput}
          placeholder={`Search ${dataIndex}`}
          value={selectedKeys[0]}
          onChange={e => setSelectedKeys(e.target.value ? [e.target.value] : [])}
          onPressEnter={() => handleDashSearch(selectedKeys, confirm, dataIndex)}
          style={{ marginBottom: 8, display: 'block' }}
        />
        <Space>
          <Button
            type="primary"
            onClick={() => handleDashSearch(selectedKeys, confirm, dataIndex)}
            icon={<SearchOutlined />}
            size="small"
            style={{ width: 90 }}
          >
            Search
          </Button>
          <Button onClick={() => handleDashReset(clearFilters)} size="small" style={{ width: 90 }}>
            Reset
          </Button>
        </Space>
      </div>
    ),
    filterIcon: filtered => <SearchOutlined style={{ color: filtered ? '#1890ff' : undefined }} />,
    onFilter: (value, record) =>
      record[dataIndex]
        ? record[dataIndex].toString().toLowerCase().includes(value.toLowerCase())
        : '',
    onFilterDropdownVisibleChange: visible => {
      if (visible) {
        setTimeout(() => dashSearchInput.current?.select(), 100);
      }
    },
    render: text =>
      searchedDashColumn === dataIndex ? (
        <Highlighter
          highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
          searchWords={[dashSearchText]}
          autoEscape
          textToHighlight={text ? text.toString() : ''}
        />
      ) : (
        text
      ),
  });

  // Column definitions for the first table
  const columns = [
    {
      title: 'Name',
      dataIndex: 'name',
      key: 'name',
      ...getColumnSearchProps('name'),
    },
    {
      title: 'Age',
      dataIndex: 'age',
      key: 'age',
      ...getColumnSearchProps('age'),
    },
  ];


function customSort(a, b) {
    const maxLength = Math.max(a.path.length, b.path.length);

    for (let i = 0; i < maxLength; i++) {
        const pathA = a.path[i] || '';
        const pathB = b.path[i] || '';
        
        // If both paths are empty, compare names
        if (pathA === '' && pathB === '') {
            continue;
        }
        
        // Compare path elements, considering empty paths
        if (pathA === '') {
            if (a.name < pathB) {
                return -1;
            } else if (a.name > pathB) {
                return 1;
            }
        } else if (pathB === '') {
            if (pathA < b.name) {
                return -1;
            } else if (pathA > b.name) {
                return 1;
            }
        } else {
            if (pathA < pathB) {
                return -1;
            } else if (pathA > pathB) {
                return 1;
            }
        }
    }
    
    // If paths are identical, compare names
    if (a.name < b.name) {
        return -1;
    }
    if (a.name > b.name) {
        return 1;
    }
    return 0;
}

data.sort(customSort);




function customSort(a, b) {
    const valueA = a.path.length > 0 ? a.path[0] : a.name;
    const valueB = b.path.length > 0 ? b.path[0] : b.name;

    if (valueA < valueB) {
        return -1;
    }
    if (valueA > valueB) {
        return 1;
    }
    // If first path elements (or names) are the same, fall back to name comparison
    if (a.name < b.name) {
        return -1;
    }
    if (a.name > b.name) {
        return 1;
    }
    return 0;
}


 const iframeRef = useRef(null);

    useEffect(() => {
        // Function to adjust the iframe height based on content
        const resizeIframe = () => {
            if (iframeRef.current) {
                iframeRef.current.style.height = iframeRef.current.contentWindow.document.body.scrollHeight + 'px';
            }
        };

        // Add event listener for resizing the iframe when the content loads
        const iframe = iframeRef.current;
        iframe.addEventListener('load', resizeIframe);

        // Cleanup event listener on component unmount
        return () => {
            iframe.removeEventListener('load', resizeIframe);
        };
    }, []);

    return (
        <div style={{ width: '100%', height: '100vh', overflow: 'hidden' }}>
            <iframe
                ref={iframeRef}
                src="YOUR_TABLEAU_DASHBOARD_URL"
                style={{ width: '100%', border: 'none' }}
                title="Tableau Dashboard"
            />
        </div>

