const express = require("express");
const app = express();

// Use PORT from environment variable or default to 3000
const PORT = process.env.PORT || 3000;

// Root route
app.get("/", (req, res) => {
  res.json({ message: "Hello from ECS! 🚀" });
});

// Health check route
app.get("/health", (req, res) => {
  res.status(200).json({ status: "UP" });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
