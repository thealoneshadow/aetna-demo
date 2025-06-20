const sortInsightsCall = async () => {
  try {
    const raw = localStorage.getItem("insight");
    if (!raw) return; // nothing to parse

    const data = JSON.parse(raw);

    if (data && data.insight !== "") {
      setInsightSQLQuery(data.query ? data.query : "No Query");
      setVertical("Mission Control");
      setIsModalOpen(false);
      setText(data.insight);
      setLoading(false);

      setTimeout(() => {
        handleSubmit(data.insight);
      }, 0); // delay of 0ms — executes after current event loop

      localStorage.removeItem("insight");
    } else {
      return;
    }
  } catch (err) {
    console.error("Error in sortInsightsCall:", err);
  }
};
