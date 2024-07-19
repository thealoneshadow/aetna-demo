function formatDateToTimestamp(inputDate) {
  // Assuming inputDate is in the format "dd/mm/yy"
  const [day, month, year] = inputDate.split('/').map(Number);

  // Create a Date object (Note: Months are 0-indexed, so we subtract 1 from the month)
  const dateObject = new Date(2000 + year, month - 1, day); // Adjust the year as needed

  // Get the timestamp in milliseconds since Unix epoch
  const timestamp = dateObject.getTime();

  // Convert to seconds (if needed)
  const timestampInSeconds = timestamp / 1000;

  // Format as ISO string with milliseconds and 'Z' for UTC
  const isoTimestamp = new Date(timestamp).toISOString();

  return isoTimestamp;
}


import { Card } from 'antd';

const { Meta } = Card;

const App: React.FC = () => (
  <Card
    hoverable
    style={{ width: 240 }}
    cover={<img alt="example" src="https://os.alipayobjects.com/rmsportal/QBnOOoLaAfKPirc.png" />}
  >
    <Meta title="Europe Street beat" description="www.instagram.com" />
  </Card>
);



        </ul>







function groupByFolderIdAndPath(arr) {
    const groupedWithUrl = {};
    const groupedWithoutUrl = {};
    const noFolderIdOrPathWithUrl = [];
    const noFolderIdOrPathWithoutUrl = [];

    arr.forEach(item => {
        const { folderId, folderPath, URL } = item;

        if (!folderId || folderId === "" || !folderPath || folderPath === "") {
            if (!URL || URL === "") {
                noFolderIdOrPathWithoutUrl.push(item);
            } else {
                noFolderIdOrPathWithUrl.push(item);
            }
        } else {
            const key = `${folderId}-${folderPath}`;
            if (!URL || URL === "") {
                if (!groupedWithoutUrl[key]) {
                    groupedWithoutUrl[key] = { folderId, folderPath, dashboards: [] };
                }
                groupedWithoutUrl[key].dashboards.push(item);
            } else {
                if (!groupedWithUrl[key]) {
                    groupedWithUrl[key] = { folderId, folderPath, dashboards: [] };
                }
                groupedWithUrl[key].dashboards.push(item);
            }
        }
    });

    return {
        groupedWithUrl: Object.values(groupedWithUrl),
        groupedWithoutUrl: Object.values(groupedWithoutUrl),
        noFolderIdOrPathWithUrl,
        noFolderIdOrPathWithoutUrl
    };
}
  
  
  const menuMap = new Map();

  items.forEach(item => {
    const { path, name, id } = item;
    const topPath = path.length > 0 ? path[0] : name;

    if (!menuMap.has(topPath)) {
      menuMap.set(topPath, []);
    }

    menuMap.get(topPath).push(item);
  });

  const renderMenu = (path, items) => {
    const subMenuMap = new Map();

    items.forEach(item => {
      const subPath = item.path.slice(path.length);
      const nextPath = subPath[0] || item.name;

      if (!subMenuMap.has(nextPath)) {
        subMenuMap.set(nextPath, []);
      }

      subMenuMap.get(nextPath).push(item);
    });

    return Array.from(subMenuMap.entries()).map(([key, subItems]) => {
      const isLastLevel = subItems.every(item => item.path.length === path.length + 1);

      if (isLastLevel) {
        return subItems.map(item => (
          <Dropdown.Item key={item.id} eventKey={item.id}>
            {item.name}
          </Dropdown.Item>
        ));
      } else {
        return (
          <Dropdown.Menu key={key} title={key}>
            {renderMenu([...path, key], subItems)}
          </Dropdown.Menu>
        );
      }
    });
  };

  return (
    <Dropdown title="My Dropdown">
      {Array.from(menuMap.entries()).map(([key, items]) => (
        items[0].path.length === 0
          ? <Dropdown.Item key={items[0].id} eventKey={items[0].id}>{items[0].name}</Dropdown.Item>
          : <Dropdown.Menu key={key} title={key}>
              {renderMenu([key], items)}
            </Dropdown.Menu>
      ))}
    </Dropdown>
  );
};
















const buildMenuStructure = (path, name, id) => {
    if (path.length === 0) {
      return <Dropdown.Item key={id} eventKey={id}>{name}</Dropdown.Item>;
    }

    const [first, ...rest] = path;
    return (
      <Dropdown.Menu key={id} title={first}>
        {buildMenuStructure(rest, name, id)}
      </Dropdown.Menu>
    );
  };

  const menuMap = new Map();

  items.forEach(item => {
    const { path, name, id } = item;
    const topPath = path.length > 0 ? path[0] : name;

    if (!menuMap.has(topPath)) {
      menuMap.set(topPath, []);
    }

    menuMap.get(topPath).push(item);
  });

  const renderMenu = (path, items) => {
    const subMenuMap = new Map();

    items.forEach(item => {
      const subPath = item.path.slice(path.length);
      const nextPath = subPath[0] || item.name;

      if (!subMenuMap.has(nextPath)) {
        subMenuMap.set(nextPath, []);
      }

      subMenuMap.get(nextPath).push(item);
    });

    return Array.from(subMenuMap.entries()).map(([key, subItems]) => {
      const isLastLevel = subItems.every(item => item.path.length === path.length + 1);

      if (isLastLevel) {
        return subItems.map(item => (
          <Dropdown.Item key={item.id} eventKey={item.id}>
            {item.name}
          </Dropdown.Item>
        ));
      } else {
        return (
          <Dropdown.Menu key={key} title={key}>
            {renderMenu([...path, key], subItems.filter(subItem => subItem.path.length > path.length))}
          </Dropdown.Menu>
        );
      }
    });
  };

  return (
    <Dropdown title="My Dropdown">
      {Array.from(menuMap.entries()).map(([key, items]) => (
        items[0].path.length === 0
          ? <Dropdown.Item key={items[0].id} eventKey={items[0].id}>{items[0].name}</Dropdown.Item>
          : <Dropdown.Menu key={key} title={key}>
              {renderMenu([key], items)}
            </Dropdown.Menu>
      ))}
    </Dropdown>
  );
};

.dropdown-menu .rs-dropdown-item:last-child,
.dropdown-item:last-child {
  margin-bottom: 0;
  padding-bottom: 0;
}


CREATE TABLE contentTable (
    id STRING(255),
    textId STRING(255),gfdhgdff

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

const vizRef = useRef(null);
  const [viz, setViz] = useState(null);
  const [vizHeight, setVizHeight] = useState('auto');

  useEffect(() => {
    const initViz = async () => {
      await loadScript('https://public.tableau.com/javascripts/api/tableau-2.min.js');
      const { tableau } = window;
      if (tableau) {
        if (viz) {
          // Dispose of the existing viz before creating a new one
          viz.dispose();
        }
        
        const newViz = new tableau.Viz(vizRef.current, url, {
          onFirstInteractive: () => {
            // Adjust the height of the viz container
            const vizElement = vizRef.current.querySelector('iframe');
            if (vizElement) {
              setVizHeight(vizElement.contentWindow.document.body.scrollHeight + 'px');
            }
          },
        });

        setViz(newViz);
      }
    };

    initViz();

    return () => {
      // Cleanup viz on component unmount
      if (viz) {
        viz.dispose();
      }
    };
  }, [url]);

  useEffect(() => {
    const handleResize = () => {
      if (viz) {
        const vizElement = vizRef.current.querySelector('iframe');
        if (vizElement) {
          setVizHeight(vizElement.contentWindow.document.body.scrollHeight + 'px');
        }
      }
    };

    window.addEventListener('resize', handleResize);

    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, [viz]);

  vizElement.style.height = `${vizElement.contentWindow.document.body.scrollHeight}px`;


import { Dropdown, Container } from 'rsuite';
import 'rsuite/dist/rsuite.min.css';

const getDropdownItems = () => {
  return [
    { type: 'item', eventKey: '1', title: 'Item 1' },
    { type: 'item', eventKey: '2', title: 'Item 2' },
    {
      type: 'menu', title: 'Menu', items: [
        { type: 'item', eventKey: '3-1', title: 'Subitem 1' },
        { type: 'item', eventKey: '3-2', title: 'Subitem 2' }
      ]
    },
    { type: 'item', eventKey: '3', title: 'Item 3' }
  ];
};

const MyDropdown = () => {
  const [dropdownItems, setDropdownItems] = useState([]);

  useEffect(() => {
    const items = getDropdownItems();  // Fetch items dynamically
    setDropdownItems(items);
  }, []);

  const renderDropdownItem = (item) => {
    if (item.type === 'item') {
      return <Dropdown.Item key={item.eventKey} eventKey={item.eventKey}>{item.title}</Dropdown.Item>;
    } else if (item.type === 'menu') {
      return (
        <Dropdown.Menu key={item.title} title={item.title}>
          {item.items.map(subItem => (
            <Dropdown.Item key={subItem.eventKey} eventKey={subItem.eventKey}>
              {subItem.title}
            </Dropdown.Item>
          ))}
        </Dropdown.Menu>
      );
    }
    return null;
  };

  return (
    <Container style={{ padding: 20 }}>
      <Dropdown title="My Dropdown">
        {dropdownItems.map(item => renderDropdownItem(item))}
      </Dropdown>
    </Container>
  );
};



const getDropdownItems = () => {
  return [
    { id: '1', name: 'Dashboard 1', path: ['Menu 1', 'Submenu 1'] },
    { id: '2', name: 'Dashboard 2', path: ['Menu 1', 'Submenu 2'] },
    { id: '3', name: 'Dashboard 3', path: ['Menu 2'] },
    { id: '4', name: 'Dashboard 4', path: [] },
  ];
};

const renderDropdownItems = (items) => {
  const buildMenuStructure = (path, name, id) => {
    if (path.length === 0) {
      return <Dropdown.Item key={id} eventKey={id}>{name}</Dropdown.Item>;
    }

    const [first, ...rest] = path;
    return (
      <Dropdown.Menu key={first} title={first}>
        {buildMenuStructure(rest, name, id)}
      </Dropdown.Menu>
    );
  };

  const menuMap = new Map();

  items.forEach(item => {
    const { path, name, id } = item;
    const topPath = path.length > 0 ? path[0] : name;

    if (!menuMap.has(topPath)) {
      menuMap.set(topPath, []);
    }

    menuMap.get(topPath).push(item);
  });

  const renderMenu = (path, items) => {
    return items.map(item => buildMenuStructure(item.path, item.name, item.id));
  };

  return (
    <Dropdown title="My Dropdown">
      {Array.from(menuMap.entries()).map(([key, items]) => (
        items[0].path.length === 0
          ? <Dropdown.Item key={items[0].id} eventKey={items[0].id}>{items[0].name}</Dropdown.Item>
          : <Dropdown.Menu key={key} title={key}>
              {renderMenu(key, items)}
            </Dropdown.Menu>
      ))}
    </Dropdown>
  );
};

const MyDropdown = () => {
  const [dropdownItems, setDropdownItems] = useState([]);

  useEffect(() => {
    const items = getDropdownItems();  // Fetch items dynamically
    setDropdownItems(items);
  }, []);

  return (
    <Container style={{ padding: 20 }}>
      {renderDropdownItems(dropdownItems)}
    </Container>
  );
};

export default MyDropdown;







const buildMenuStructure = (items, currentPath = []) => {
  const menuMap = new Map();

  items.forEach(item => {
    const [first, ...rest] = item.path.slice(currentPath.length);
    if (first !== undefined) {
      if (!menuMap.has(first)) {
        menuMap.set(first, []);
      }
      menuMap.get(first).push(item);
    }
  });

  const menuItems = [];

  menuMap.forEach((subItems, title) => {
    if (subItems[0].path.length === currentPath.length + 1) {
      // If this is the last part of the path, create Dropdown.Item
      subItems.forEach(item => {
        menuItems.push(
          <Dropdown.Item key={item.id} eventKey={item.id}>
            {item.name}
          </Dropdown.Item>
        );
      });
    } else {
      // Otherwise, create Dropdown.Menu and recursively add its children
      menuItems.push(
        <Dropdown.Menu key={title} title={title}>
          {buildMenuStructure(subItems, [...currentPath, title])}
        </Dropdown.Menu>
      );
    }
  });

  return menuItems;