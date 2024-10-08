from flask import Flask, jsonify
from office365.sharepoint.client_context import ClientContext
from office365.runtime.auth.client_credential import ClientCredential
import os

app = Flask(__name__)

# Get SharePoint credentials from environment variables
client_id = os.getenv('SHAREPOINT_CLIENT_ID')
client_secret = os.getenv('SHAREPOINT_CLIENT_SECRET')
tenant = os.getenv('SHAREPOINT_TENANT')
site_url = os.getenv('SHAREPOINT_SITE_URL')

# Function to authenticate and get client context
def get_sharepoint_context():
    credentials = ClientCredential(client_id, client_secret)
    ctx = ClientContext(site_url).with_credentials(credentials)
    return ctx

@app.route('/get-sharepoint-items', methods=['GET'])
def get_sharepoint_items():
    try:
        # Get the client context
        ctx = get_sharepoint_context()

        # Specify the list name you want to retrieve items from
        list_title = "Your List Title"  # Replace with your list title
        sp_list = ctx.web.lists.get_by_title(list_title)

        # Load and execute the query
        items = sp_list.items.get().execute_query()

        # Extract the data and convert to JSON format
        result = [{"ID": item.properties["Id"], "Title": item.properties["Title"]} for item in items]

        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)}), 500



         # Get the file path from the query parameter
        file_path = request.args.get('file_path')
        
        if not file_path:
            return jsonify({"error": "Please provide the file path as a query parameter"}), 400

        # Get the client context
        ctx = get_sharepoint_context()

        # Get the file from SharePoint
        file = ctx.web.get_file_by_server_relative_url(file_path).get().execute_query()

        # Download the file content to memory
        file_content = io.BytesIO()
        file.download(file_content).execute_query()

        # Move the pointer to the beginning of the file
        file_content.seek(0)

        # Send the file as a response
        return send_file(
            file_content,
            as_attachment=True,
            download_name=os.path.basename(file_path)
        )

if __name__ == '__main__':
    app.run(debug=True)


export SHAREPOINT_CLIENT_ID='your-client-id'
export SHAREPOINT_CLIENT_SECRET='your-client-secret'
export SHAREPOINT_TENANT='your-tenant-name'
export SHAREPOINT_SITE_URL='https://your-tenant.sharepoint.com/sites/yoursite'


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


import React, { useState } from 'react';
import { Nav, Sidenav, Modal, Button } from 'rsuite';
import DashboardIcon from '@rsuite/icons/legacy/Dashboard';
import GroupIcon from '@rsuite/icons/legacy/Group';
import './App.css';

const App = () => {
  const [showModal, setShowModal] = useState(false); // Modal visibility state

  const handleModalOpen = () => {
    setShowModal(true); // Show modal
  };

  const handleModalClose = () => {
    setShowModal(false); // Hide modal
  };

  return (
    <>
      {/* Navbar Wrapper */}
      <div className="navbar-container">
        <Nav activeKey="1">
          <Nav.Item eventKey="1" onClick={handleModalOpen}>Home</Nav.Item>
          <Nav.Item eventKey="2">About</Nav.Item>
        </Nav>
      </div>

      {/* Sidebar Wrapper */}
      <div className="sidebar-container">
        <Sidenav defaultOpenKeys={['3', '4']} appearance="subtle">
          <Sidenav.Body>
            <Nav>
              <Nav.Item eventKey="1" icon={<DashboardIcon />}>Dashboard</Nav.Item>
              <Nav.Menu eventKey="2" title="User Group" icon={<GroupIcon />} className="custom-submenu">
                <Nav.Item eventKey="2-1">User 1</Nav.Item>
                <Nav.Item eventKey="2-2">User 2</Nav.Item>
              </Nav.Menu>
            </Nav>
          </Sidenav.Body>
        </Sidenav>
      </div>

      {/* Modal with iframe */}
      <Modal open={showModal} onClose={handleModalClose} size="lg">
        <Modal.Header>
          <Modal.Title>Modal with Iframe</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <iframe
            src="https://www.example.com"
            title="iframe"
            width="100%"
            height="400px"
            style={{ border: 'none' }}
          />
        </Modal.Body>
        <Modal.Footer>
          <Button onClick={handleModalClose} appearance="primary">
            Close
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
};

export default App;




const disabledDate = (current) => {
  if (!current) return false; // Handle null or undefined

  const today = moment(); // Get today's date
  const currentYear = today.year(); // Get the current year
  const cutoffDate = moment(`${currentYear}-10-01`); // October 1st of the current year
  const fiveYearsAgo = currentYear - 5; // 5 years ago

  // If today is before October 1st, disable the current year and any future years
  if (today.isBefore(cutoffDate)) {
    return current.year() > currentYear || current.year() === currentYear;
  }

  // After October 1st, only disable future years beyond the current year
  return current.year() > currentYear || current.year() < fiveYearsAgo;
};


function addYearIfMissing(str) {
  // Regular expression to check if string contains a four-digit number (year)
  const yearRegex = /\b\d{4}\b/;

  // Check if the string contains a year
  if (!yearRegex.test(str)) {
    return `2024 ${str}`;
  }

  return str;
}


db = mysql.connector.connect(
    host="localhost",  # Your database host
    user="username",   # Your database username
    password="password",  # Your database password
    database="your_database_name"  # Your database name
)

# Function to authenticate and get client context
def get_sharepoint_context():
    credentials = ClientCredential(client_id, client_secret)
    ctx = ClientContext(site_url).with_credentials(credentials)
    return ctx

@app.route('/list-files', methods=['GET'])
def list_files():
    try:
        ctx = get_sharepoint_context()
        
        # Specify the document library name (e.g., 'Documents' for the default library)
        library_name = "Documents"

        # Query the document library
        files = ctx.web.lists.get_by_title(library_name).items.select("FileLeafRef", "FileRef").get().execute_query()

        # Prepare a list of file metadata
        file_list = []
        for file in files:
            file_list.append({
                "filename": file.properties['FileLeafRef'],
                "file_url": file.properties['FileRef']
            })

        return jsonify(file_list), 200

    except Exception as e:
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500

