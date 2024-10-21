 useEffect(() => {
    // When the component is mounted, record the start time
    const start = Date.now();
    setStartTime(start);

    // Function to be called when user leaves the dashboard
    const handleLeave = () => {
      const endTime = Date.now();
      const timeSpent = Math.floor((endTime - startTime) / 1000); // in seconds

      // API call to save the time spent
      axios.post('/api/save-time', {
        page: 'Dashboard', // Adjust this according to the page name
        timeSpent: timeSpent
      })
      .then(response => {
        console.log('Time saved successfully:', response.data);
      })
      .catch(error => {
        console.error('Error saving time:', error);
      });
    };

    // When component unmounts or user navigates away
    window.addEventListener('beforeunload', handleLeave);

    return () => {
      // Cleanup event listener
      window.removeEventListener('beforeunload', handleLeave);
      handleLeave(); // Ensure the time is saved if the component unmounts
    };
  }, [startTime]);


    const location = useLocation();
  const [startTime, setStartTime] = useState(Date.now());
  const [currentPage, setCurrentPage] = useState(location.pathname);

  useEffect(() => {
    // When the location changes (i.e., user navigates to another page)
    return () => {
      const endTime = Date.now();
      const timeSpent = Math.floor((endTime - startTime) / 1000); // in seconds

      // API call to save the time spent on the previous page
      axios.post('/api/save-time', {
        page: currentPage,
        timeSpent: timeSpent,
      })
      .then(response => {
        console.log('Time saved successfully:', response.data);
      })
      .catch(error => {
        console.error('Error saving time:', error);
      });

      // Reset start time and page for the new route
      setStartTime(Date.now());
      setCurrentPage(location.pathname);
    };
  }, [location]);


   useEffect(() => {
    // Function to save time spent
    const saveTimeSpent = () => {
      const endTime = Date.now();
      const timeSpent = Math.floor((endTime - startTime) / 1000); // time in seconds

      // API call to save the time spent on the current page
      axios.post('/api/save-time', {
        page: currentPage,
        timeSpent: timeSpent,
      })
      .then(response => {
        console.log('Time saved successfully:', response.data);
      })
      .catch(error => {
        console.error('Error saving time:', error);
      });
    };

    // Track route changes (navigating between dashboards)
    const handleRouteChange = () => {
      saveTimeSpent(); // Save the time spent on the current page before navigating away
      setStartTime(Date.now()); // Reset start time for the new route
      setCurrentPage(location.pathname); // Update the current page
    };

    // Listen for route changes using React Router's useLocation
    handleRouteChange();

    // Handle tab close, page reload, or navigating away from the app
    const handleBeforeUnload = (event) => {
      saveTimeSpent(); // Save the time when user reloads, closes the tab, or navigates away
    };

    window.addEventListener('beforeunload', handleBeforeUnload);

    // Cleanup listeners when component unmounts or location changes
    return () => {
      window.removeEventListener('beforeunload', handleBeforeUnload);
      saveTimeSpent(); // Ensure time is saved when navigating to another route
    };
  }, [location, startTime, currentPage]);

  return <>{children}</>;
};

 const startTimeRef = useRef(Date.now()); // Use ref to track start time
  const currentPageRef = useRef(location.pathname); // Use ref to track the current page

  // Function to calculate time spent and save it
  const saveTimeSpent = () => {
    const endTime = Date.now();
    const timeSpent = Math.floor((endTime - startTimeRef.current) / 1000); // time in seconds

    // Send API call with the time spent on the page
    axios.post('/api/save-time', {
      page: currentPageRef.current,  // Ref ensures correct page is used
      timeSpent: timeSpent,
    })
    .then(response => {
      console.log('Time saved successfully:', response.data);
    })
    .catch(error => {
      console.error('Error saving time:', error);
    });
  };

  useEffect(() => {
    // Handle when user navigates to a different route
    const handleRouteChange = () => {
      saveTimeSpent();  // Save the time spent on the current page before navigating away
      startTimeRef.current = Date.now(); // Reset start time for the new page
      currentPageRef.current = location.pathname; // Update the current page ref
    };

    // Handle tab close, page reload, or navigating away
    const handleBeforeUnload = () => {
      saveTimeSpent();  // Save time when user closes tab or reloads
    };

    // Listen for beforeunload events (for tab close, reload, etc.)
    window.addEventListener('beforeunload', handleBeforeUnload);

    // Save time spent when route changes
    handleRouteChange(); // Call on initial load and when location changes

    return () => {
      window.removeEventListener('beforeunload', handleBeforeUnload);
      saveTimeSpent(); // Ensure time is saved when unmounting the component
    };
  }, [location]);


  WITH DuplicateRows AS (
    SELECT id, name, 
           ROW_NUMBER() OVER (PARTITION BY name ORDER BY created_at) AS row_num
    FROM your_table
    WHERE userId = 'your_userId'
      AND created_at BETWEEN '2024-10-15 09:00:00' AND '2024-10-18 18:11:00'
)
-- Delete duplicates, keeping only 1 row per name
DELETE FROM your_table
WHERE id IN (
    SELECT id
    FROM DuplicateRows
    WHERE row_num > 1
);

DELETE FROM your_table
WHERE id IN (
    SELECT id
    FROM (
        SELECT id, 
               ROW_NUMBER() OVER (PARTITION BY name ORDER BY created_at) AS row_num
        FROM your_table
        WHERE created_at BETWEEN '2024-10-15T09:00:00Z' AND '2024-10-18T18:11:00Z'
    )
    WHERE row_num > 1
);


SELECT id, name, created_at,
       ROW_NUMBER() OVER (PARTITION BY name ORDER BY created_at) AS row_num
FROM your_table
WHERE created_at BETWEEN '2024-10-15T09:00:00Z' AND '2024-10-18T18:11:00Z';



SELECT MIN(created_at) AS earliest_created_at, name
FROM your_table
WHERE created_at BETWEEN '2024-10-15T09:00:00Z' AND '2024-10-18T18:11:00Z'
GROUP BY name;


DELETE FROM your_table
WHERE created_at BETWEEN '2024-10-15T09:00:00Z' AND '2024-10-18T18:11:00Z'
AND (name, created_at) NOT IN (
    SELECT name, MIN(created_at)
    FROM your_table
    WHERE created_at BETWEEN '2024-10-15T09:00:00Z' AND '2024-10-18T18:11:00Z'
    GROUP BY name
);