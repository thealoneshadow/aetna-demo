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

function formatTime(seconds) {
  // Calculate days, hours, minutes, and remaining seconds
  const days = Math.floor(seconds / (24 * 3600));
  seconds %= 24 * 3600;

  const hours = Math.floor(seconds / 3600);
  seconds %= 3600;

  const minutes = Math.floor(seconds / 60);
  seconds %= 60;

  // Build the result string
  const result = [];
  if (days > 0) result.push(`${days} day${days > 1 ? 's' : ''}`);
  if (hours > 0) result.push(`${hours} hour${hours > 1 ? 's' : ''}`);
  if (minutes > 0) result.push(`${minutes} minute${minutes > 1 ? 's' : ''}`);
  if (seconds > 0) result.push(`${seconds} second${seconds > 1 ? 's' : ''}`);

  return result.join(', ');
}
