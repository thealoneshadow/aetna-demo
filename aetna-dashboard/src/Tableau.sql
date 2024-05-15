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


from flask import Flask, redirect, url_for, session
from authlib.integrations.flask_client import OAuth
from authlib.integrations.requests_client import OAuth2Session
import os

# Initialize Flask app
app = Flask(__name__)
app.secret_key = 'random_secret_key'  # Replace with a secure secret key

# OAuth configuration
oauth = OAuth(app)
oauth.register(
    name='google',
    client_id=os.getenv('GOOGLE_CLIENT_ID'),
    client_secret=os.getenv('GOOGLE_CLIENT_SECRET'),
    authorize_url='https://accounts.google.com/o/oauth2/auth',
    authorize_params=None,
    access_token_url='https://accounts.google.com/o/oauth2/token',
    access_token_params=None,
    refresh_token_url=None,
    redirect_uri=os.getenv('GOOGLE_REDIRECT_URI'),
    client_kwargs={'scope': 'openid profile email'},
)

# Define the login route
@app.route('/login')
def login():
    google = oauth.create_client('google')
    redirect_uri = url_for('authorize', _external=True)
    return google.authorize_redirect(redirect_uri)

# Define the callback route
@app.route('/authorize')
def authorize():
    google = oauth.create_client('google')
    token = google.authorize_access_token()
    user_info = google.parse_id_token(token)
    session['user'] = user_info
    return redirect('/protected')

# Define a protected route
@app.route('/protected')
def protected():
    user = session.get('user')
    if user:
        return f'Hello, {user["name"]}!'
    return redirect(url_for('login'))

# Define a logout route
@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)
