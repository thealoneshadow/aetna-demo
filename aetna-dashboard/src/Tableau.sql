from flask import Response, stream_with_context

def generate_large_csv():
    query = "SELECT * FROM your_table"
    query_job = client.query(query)

    def stream():
        for row in query_job:
            yield ",".join(map(str, row)) + "\n"

    return Response(
        stream_with_context(stream()),
        mimetype="text/csv",
        headers={"Content-Disposition": "attachment; filename=data.csv"},
    )




export default function AutoLogoutPopup() {
  const [showPopup, setShowPopup] = useState(false);
  const [inactiveTime, setInactiveTime] = useState(0);
  
  useEffect(() => {
    const interval = setInterval(() => {
      setInactiveTime((prev) => prev + 1);
    }, 60000); // 1-minute interval

    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    if (inactiveTime === 9) {
      setShowPopup(true);
    }
    if (inactiveTime >= 10) {
      handleLogout();
    }
  }, [inactiveTime]);

  const handleActive = () => {
    setInactiveTime(0);
    setShowPopup(false);
  };

  const handleLogout = () => {
    alert("User logged out due to inactivity.");
    // Implement logout logic here
  };

  return (
    <div>
      {showPopup && (
        <div style={{ position: "fixed", top: 0, left: 0, width: "100%", height: "100%", display: "flex", alignItems: "center", justifyContent: "center", backgroundColor: "rgba(0, 0, 0, 0.5)" }}>
          <div style={{ backgroundColor: "white", padding: "16px", borderRadius: "8px", boxShadow: "0px 4px 6px rgba(0, 0, 0, 0.1)" }}>
            <p>You have been inactive. Click "Active" to continue.</p>
            <button onClick={handleActive} style={{ backgroundColor: "#3B82F6", color: "white", padding: "8px", borderRadius: "4px", marginTop: "8px", border: "none", cursor: "pointer" }}>Active</button>
          </div>
        </div>
      )}
    </div>
  );
}
