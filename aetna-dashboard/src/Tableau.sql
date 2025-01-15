 tableauViz.addEventListener("firstinteractive", () => {
      console.log("Tableau Viz is interactive");

      // Get the workbook and active sheet
      const workbook = tableauViz.getWorkbook();
      const activeSheet = workbook.getActiveSheet();

      // Example: Listen for filter changes
      activeSheet.addEventListener("filterchange", (event) => {
        console.log("Filter changed:", event);
      });

      // Example: Listen for parameter changes
      workbook.addEventListener("parameterchange", (event) => {
        console.log("Parameter changed:", event);
      });
