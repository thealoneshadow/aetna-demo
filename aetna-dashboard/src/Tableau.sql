useEffect(() => {
    const monitorChildWindow = setInterval(() => {
      // Check all open windows (excluding the main window)
      for (const win of window) {
        if (win !== window && !win.closed) {
          try {
            // If the child window is detected and has navigated to a URL
            const childUrl = win.location.href;

            // Ensure it's the R Shiny URL (optional check)
            if (childUrl.includes(shinyAppUrl)) {
              // Redirect the main window to the child window's URL
              window.location.href = childUrl;

              // Close the child window
              win.close();
            }
          } catch (e) {
            console.log('Cross-origin error or window not yet navigated:', e);
          }
        }
      }
    }, 1000); // Check every second

    return () => clearInterval(monitorChildWindow); // Cleanup interval on component unmount
  }, []);
