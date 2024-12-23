const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");
const axios = require("axios");

const app = express();
app.use(cors({origin: true})); // Remove spaces around curly braces

// Proxy endpoint
app.get("/proxy", async (req, res) => {
  const imagePath = req.query.imagePath; // Full image path
  if (!imagePath) {
    return res.status(400).send("Missing 'imagePath' query parameter");
  }

  try {
    // Fetch the image

    const response = await axios.get(imagePath, {
      responseType: "arraybuffer",
    });

    res.set("Content-Type", "image/jpeg"); // Set response content type
    res.send(response.data); // Send the image data back
  } catch (error) {
    console.error("Error fetching image:", error);
    res.status(500).send("Error fetching image");
  }
});


exports.app = functions.https.onRequest(app);
