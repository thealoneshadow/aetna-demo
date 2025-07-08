const [labels, setLabels] = useState(null);

  // Poll every 3s until localStorage value exists
  if (!labels) {
    const pollForLabels = () => {
      const val = localStorage.getItem("finalLabel");
      if (val) {
        try {
          setLabels(JSON.parse(val));
        } catch (err) {
          console.error("Invalid JSON in finalLabel");
        }
      } else {
        setTimeout(pollForLabels, 3000); // try again in 3s
      }
    };

    pollForLabels(); // Start polling immediately
  }

  if (!labels) {
    return <p>Waiting for chart data...</p>;
  }
