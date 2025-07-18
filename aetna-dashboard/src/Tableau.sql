import React from "react";

const App = () => {
  return (
    <div>
      {/* Fixed Header */}
      <div style={styles.header}>Fixed Header</div>

      {/* Scrollable Content */}
      <div style={styles.content}>
        {Array.from({ length: 100 }, (_, i) => (
          <p key={i}>Scrollable content line {i + 1}</p>
        ))}
      </div>

      {/* Fixed Footer */}
      <div style={styles.footer}>Fixed Footer</div>
    </div>
  );
};

const styles = {
  header: {
    position: "fixed",
    top: 0,
    left: 0,
    right: 0,
    height: "50px",
    backgroundColor: "#333",
    color: "#fff",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    zIndex: 1000,
  },
  content: {
    marginTop: "50px", // space for header
    marginBottom: "50px", // space for footer
    padding: "20px",
    height: "calc(100vh - 100px)", // full height minus fixed header and footer
    overflowY: "auto",
    backgroundColor: "#f0f0f0",
  },
  footer: {
    position: "fixed",
    bottom: 0,
    left: 0,
    right: 0,
    height: "50px",
    backgroundColor: "#333",
    color: "#fff",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    zIndex: 1000,
  },
};

export default App;
