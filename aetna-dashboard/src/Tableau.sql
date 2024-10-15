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