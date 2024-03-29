const containerRef = useRef(null);
const [filterValues, setFilterValues] = useState({});

useEffect(() => {
  // Initialize Tableau viz
  const vizUrl = "YOUR_TABLEAU_DASHBOARD_URL";
  const options = {
    hideTabs: true,
    hideToolbar: true,
    onFirstInteractive: () => {
      console.log("Tableau viz loaded.");
    },
  };
  const viz = new window.tableau.Viz(containerRef.current, vizUrl, options);

  // Listen for filter change events
  viz.addEventListener(
    window.tableau.TableauEventName.FILTER_CHANGE,
    handleFilterChange
  );

  // Cleanup function
  return () => {
    // Remove event listener when component unmounts
    viz.removeEventListener(
      window.tableau.TableauEventName.FILTER_CHANGE,
      handleFilterChange
    );
  };
}, []);

const handleFilterChange = (filterEvent) => {
  // Extract filter information from the event
  const filterName = filterEvent.getFieldName();
  const filterValues = filterEvent.getFilterAsync().getAppliedValues();
  // Update filter values in component state
  setFilterValues((prevState) => ({
    ...prevState,
    [filterName]: filterValues,
  }));
};
