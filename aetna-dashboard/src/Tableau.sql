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