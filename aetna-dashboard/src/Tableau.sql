import html2canvas from 'html2canvas';
import jsPDF from 'jspdf';

const downloadPDF = async () => {
  if (!chartRef.current) return;

  // 1. Use html2canvas with proper scale for sharpness
  const canvas = await html2canvas(chartRef.current, {
    scale: 2,           // Increase for higher resolution
    useCORS: true       // Needed if using external fonts/images
  });

  const imgData = canvas.toDataURL('image/png');

  // 2. Get actual size of canvas in pixels
  const canvasWidth = canvas.width;
  const canvasHeight = canvas.height;

  // 3. Create PDF with same dimensions in px units
  const pdf = new jsPDF({
    orientation: 'landscape',
    unit: 'px',
    format: [canvasWidth, canvasHeight] // Match to canvas
  });

  // 4. Add image to PDF at full size
  pdf.addImage(imgData, 'PNG', 0, 0, canvasWidth, canvasHeight);

  // 5. Save the file
  pdf.save(`${selectedChart}_chart.pdf`);

  // Optional: log for debug
  console.log('Canvas size:', canvasWidth, canvasHeight);
};
