import { Tableau } from "tableau-api-js";

const TableauDashboard = () => {
  const containerRef = useRef(null);
  const [filterValues, setFilterValues] = useState({});

  useEffect(() => {
    Tableau.init(containerRef.current, "YOUR_TABLEAU_DASHBOARD_URL");

    // Listen for filter change events
    const viz = Tableau.getViz(containerRef.current);
    viz.addEventListener(
      Tableau.TableauEventName.FILTER_CHANGE,
      handleFilterChange
    );

    // Cleanup function
    return () => {
      // Remove event listener when component unmounts
      viz.removeEventListener(
        Tableau.TableauEventName.FILTER_CHANGE,
        handleFilterChange
      );
      // Clean up Tableau viz when component unmounts
      Tableau.cleanup(containerRef.current);
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

  return (
    <div>
      <div ref={containerRef}></div>
      {/* Render any other components using filterValues as needed */}
    </div>
  );
};

export default TableauDashboard;
