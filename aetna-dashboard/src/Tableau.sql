 const handleScreenshot = async () => {
    if (!chartRef.current) return;

    const canvas = await html2canvas(chartRef.current, {
      scale: 2, // for sharper image
      useCORS: true
    });

    const imgData = canvas.toDataURL("image/png");

    // Create a download link
    const link = document.createElement("a");
    link.href = imgData;
    link.download = "chart_screenshot.png";
    link.click();
  };
