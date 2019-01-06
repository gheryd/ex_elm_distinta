const express = require('express');
const app = express();
const path = require('path');
const Product = require("./models/product")

const distPath = path.join(__dirname, '../../dist');
//const indexHtml = path.join(distPath, "index.html");
const assets = express.static(distPath);

app.get("/api/products", async (req, res)=>{
    const product = new Product();
    console.log("call get api/products");
    try{
        const products = await product.getAll();
        res.send(products);
    }catch(err){
        console.log("errore!!!", err.message);
        res.send(err.message);
    }

})

app.use(assets);
/*
app.get("/", (req,res)=>{
    res.sendFile(indexHtml)
});
*/
app.listen(3001, ()=>console.log("start http server, port = 3001..."))
