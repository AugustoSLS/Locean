const express = require("express");
const app = express();
const port = 3000;


var session = require("express-session");

app.use(express.static("Locean/public"));

app.set("view engine", "ejs");
app.set("views", "./Locean/views");

app.use(express.json()); 
app.use(express.urlencoded({ extended: true }));

app.use(session({
    secret: "keyboard cat",
    resave: false,
    saveUninitialized: false,
}));

var rotas = require("./routes/router");
app.use("/", rotas);

app.listen(port, () => {
  console.log(`Servidor ouvindo na porta ${port}`);
});
