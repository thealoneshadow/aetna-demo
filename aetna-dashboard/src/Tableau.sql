const data = [
  { response: "A", time: "5min 10.5second" },
  { response: "B", time: "2min 3.25second" },
  { response: "C", time: "1min 59.8second" }
];

// function to parse "Xmin Ysecond" into total seconds
function parseTime(str) {
  const minMatch = str.match(/(\d+)min/);
  const secMatch = str.match(/([\d.]+)second/);

  const minutes = minMatch ? parseInt(minMatch[1], 10) : 0;
  const seconds = secMatch ? parseFloat(secMatch[1]) : 0;

  return minutes * 60 + seconds;
}

// sum all times in seconds
let totalSeconds = data.reduce((sum, item) => sum + parseTime(item.time), 0);

// convert back to minutes + seconds
let finalMinutes = Math.floor(totalSeconds / 60);
let finalSeconds = (totalSeconds % 60).toFixed(2);

let finalTime = `${finalMinutes} minutes ${finalSeconds} seconds`;

console.log(finalTime);
// 👉 "9 minutes 13.55 seconds"
