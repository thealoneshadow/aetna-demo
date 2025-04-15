

<div>
      <div
        ref={scrollRef}
        style={{
          height: "300px",
          width: "400px",
          overflowY: "auto",
          border: "2px solid #ccc",
          padding: "10px",
        }}
      >
        <div style={{ height: "1000px", background: "linear-gradient(white, lightblue)" }}>
          {/* Scrollable content */}
          <p>Scroll inside me!</p>
          {[...Array(50)].map((_, i) => (
            <p key={i}>Line {i + 1}</p>
          ))}
        </div>
      </div>

      <div style={{ marginTop: "10px", display: "flex", gap: "10px" }}>
        <button onClick={scrollToTop}>⬆️ Scroll to Top</button>
        <button onClick={scrollToBottom}>⬇️ Scroll to Bottom</button>
      </div>
    </div>

const scrollRef = useRef(null);

  const scrollToTop = () => {
    scrollRef.current?.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  };

  const scrollToBottom = () => {
    scrollRef.current?.scrollTo({
      top: scrollRef.current.scrollHeight,
      behavior: "smooth",
    });
  };


    .scroll-buttons {
      margin-top: 10px;
      display: flex;
      gap: 10px;
    }

    .scroll-buttons button {
      padding: 8px 12px;
      font-size: 16px;
      cursor: pointer;
    }
