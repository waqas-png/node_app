const express = require("express");
const redis = require("redis");

const app = express();
const port = process.env.PORT || 3000;

// Redis connection
const client = redis.createClient({
  url: "redis://redis:6379",
});

client.on("error", (err) => console.error("Redis error:", err));

app.get("/", async (req, res) => {
  try {
    await client.connect();
    await client.set("message", "Hello from Node.js & Redis in Docker!");
    const message = await client.get("message");
    await client.disconnect();
    res.send(`Redis says: ${message}`);
  } catch (err) {
    res.status(500).send("Redis connection error: " + err.message);
  }
});
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
  });