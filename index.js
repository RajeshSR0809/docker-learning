const express = require("express");
const app = express();


app.get("/home", (req, res) => {
    return res.send({"data": "home page"});
});


app.listen(3000)