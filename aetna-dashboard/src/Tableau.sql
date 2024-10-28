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


  import React, { useEffect, useState } from 'react';

const InactivityLogout = () => {
  const [isActive, setIsActive] = useState(true);
  let inactivityTimeout;

  const logoutUser = () => {
    // Implement your logout logic here
    console.log("User logged out due to inactivity");
    // For example: redirect to login page, clear user state, etc.
  };

  const resetTimer = () => {
    setIsActive(true);
    clearTimeout(inactivityTimeout);
    inactivityTimeout = setTimeout(() => {
      setIsActive(false);
      logoutUser();
    }, 300000); // 5 minutes
  };

  const handleActivity = () => {
    resetTimer();
  };

  useEffect(() => {
    // Set up event listeners for user activity
    window.addEventListener('mousemove', handleActivity);
    window.addEventListener('keypress', handleActivity);
    window.addEventListener('click', handleActivity);

    resetTimer(); // Start the inactivity timer on mount

    return () => {
      // Cleanup event listeners and timeout on component unmount
      window.removeEventListener('mousemove', handleActivity);
      window.removeEventListener('keypress', handleActivity);
      window.removeEventListener('click', handleActivity);
      clearTimeout(inactivityTimeout);
    };
  }, []);

  return (
    <div>
      <h1>{isActive ? "User is Active" : "User has been logged out due to inactivity"}</h1>
    </div>
  );
};

export default InactivityLogout;