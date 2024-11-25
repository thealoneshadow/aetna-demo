const TableauViz = () => {
  useEffect(() => {
    const tableauViz = document.getElementById("tableauViz");

    tableauViz.addEventListener("load", () => {
      const iframe = tableauViz.querySelector("iframe");
      if (iframe) {
        iframe.style.width = "1600px";
        iframe.style.height = "800px";
      }
    });
  }, []);

