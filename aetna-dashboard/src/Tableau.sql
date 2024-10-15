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