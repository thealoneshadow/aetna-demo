import React, { useEffect, useRef } from "react";

const TableauDashboard = () => {
  const iframeRef = useRef(null);

  useEffect(() => {
    const handleMessage = (event) => {
      if (event.origin !== "https://your-tableau-server.com") {
        return; // Ensure the message is from the Tableau server
      }

      if (event.data.type === "tableauHeight") {
        // Update the height of the iframe based on the received height
        iframeRef.current.style.height = event.data.height + "px";
      }
    };

    window.addEventListener("message", handleMessage);

    return () => {
      window.removeEventListener("message", handleMessage);
    };
  }, []);

  return (
    <iframe
      ref={iframeRef}
      title="Tableau Dashboard"
      src="https://your-tableau-server.com/dashboard-url"
      width="100%"
      height="600" // Initial height, you can adjust as needed
      frameBorder="0"
    />
  );
};

export default TableauDashboard;
