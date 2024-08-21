 const shinyAppBaseUrl = 'https://your-rshiny-dashboard-url'; // Replace with your R Shiny base URL
  const [childWindow, setChildWindow] = useState(null);

  useEffect(() => {
    const monitorChildWindow = setInterval(() => {
      if (childWindow && !childWindow.closed) {
        try {
          const childUrl = childWindow.location.href;

          // If the child window URL matches or includes the Shiny dashboard's base URL
          if (childUrl.includes(shinyAppBaseUrl)) {
            window.location.href = childUrl; // Redirect the main window
            childWindow.close(); // Close the child window
            setChildWindow(null); // Clear the child window reference
          }
        } catch (e) {
          console.log('Waiting for the child window to navigate or cross-origin issue:', e);
        }
      }
    }, 1000); // Check every second

    return () => clearInterval(monitorChildWindow); // Clean up the interval on component unmount
  }, [childWindow]);

  // Detect and store the child window when it is opened
  useEffect(() => {
    const originalWindowOpen = window.open;

    // Override the default window.open to detect when the child window opens
    window.open = function (url, name, specs) {
      const newWindow = originalWindowOpen(url, name, specs);
      setChildWindow(newWindow); // Save the reference to the new window
      return newWindow;
    };

    return () => {
      window.open = originalWindowOpen; // Restore original window.open on cleanup
    };
  }, []);
ert



const getCookie = (name) => {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
  return null;
};

const CheckCookieComponent = () => {
  const [cookieExists, setCookieExists] = useState(false);

  useEffect(() => {
    const cookieName = 'rsconnect-legacy';
    const cookieValue = getCookie(cookieName);

    if (cookieValue) {
      setCookieExists(true);
      console.log(`${cookieName} exists with value: ${cookieValue}`);
    } else {
      setCookieExists(false);
      console.log(`${cookieName} does not exist`);
    }
  }, []);