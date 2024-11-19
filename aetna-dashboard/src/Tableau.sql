const [sessionStartTime, setSessionStartTime] = useState(null); // Track session start time
  const [currentDashboard, setCurrentDashboard] = useState(null); // Track the current dashboard

  // Function to call the API
  const saveSessionData = async () => {
    if (sessionStartTime && currentDashboard) {
      const sessionEndTime = Date.now(); // Capture session end time
      const duration = sessionEndTime - sessionStartTime; // Calculate session duration

      try {
        await fetch('https://api.example.com/save-session', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            dashboard: currentDashboard,
            startTime: new Date(sessionStartTime).toISOString(),
            endTime: new Date(sessionEndTime).toISOString(),
            duration,
          }),
        });
        console.log('Session data saved successfully.');
      } catch (error) {
        console.error('Failed to save session data:', error);
      }
    }
  };

  // Handle page reload or tab close
  useEffect(() => {
    const handleUnload = () => {
      saveSessionData(); // Save session on unload
    };

    window.addEventListener('beforeunload', handleUnload);

    return () => {
      window.removeEventListener('beforeunload', handleUnload);
    };
  }, [sessionStartTime, currentDashboard]);

  // Track route changes
  useEffect(() => {
    if (location.pathname.startsWith('/dashboard')) {
      const dashboardId = location.pathname.split('/')[2]; // Example: Extract dashboard ID
      setCurrentDashboard(dashboardId);

      // Start session tracking
      setSessionStartTime(Date.now());
    } else {
      // Save session when navigating away from the dashboard
      saveSessionData();
    }
  }, [location]);

