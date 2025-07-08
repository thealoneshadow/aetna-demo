import html2canvas from "html2canvas";
import jsPDF from "jspdf";

const downloadChartAsPDF = async () => {
  if (!chartRef.current) return;

  const canvas = await html2canvas(chartRef.current, {
    scale: 2,
    useCORS: true,
    windowWidth: chartRef.current.scrollWidth,
    windowHeight: chartRef.current.scrollHeight,
  });

  const imgData = canvas.toDataURL("image/png");

  const canvasWidth = canvas.width;
  const canvasHeight = canvas.height;

  // ✅ Match PDF size to canvas size in pixels
  const pdf = new jsPDF({
    orientation: canvasWidth > canvasHeight ? "landscape" : "portrait",
    unit: "px",
    format: [canvasWidth, canvasHeight],
  });

  // ✅ Fill the entire page with the captured image
  pdf.addImage(imgData, "PNG", 0, 0, canvasWidth, canvasHeight);

  // ✅ Save the PDF
  pdf.save("chart_full.pdf");

  console.log("Canvas size:", canvasWidth, canvasHeight);
};
