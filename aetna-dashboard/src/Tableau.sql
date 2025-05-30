<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Fetch Button Example</title>
</head>
<body>
  <h2>Fetch API Example</h2>
  <button onclick="sendRequest()">Click to Send Fetch Request</button>

  <script>
    function sendRequest() {
      const payload = {
        name: "Divyanshu",
        age: 25
      };

      fetch("http://localhost:5000/upload", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(payload)
      })
      .then(response => response.json())
      .then(data => {
        console.log("✅ Response from server:", data);
        alert("Request successful! Check console.");
      })
      .catch(error => {
        console.error("❌ Error:", error);
        alert("Request failed.");
      });
    }
  </script>
</body>
</html>
