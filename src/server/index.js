const express = require('express');
const app = express();
const path = require('path');
const Product = require("./models/product")
const Component = require("./models/component")
const Category = require("./models/category")

const distPath = path.join(__dirname, '../../dist');
//const indexHtml = path.join(distPath, "index.html");
const assets = express.static(distPath);

app.get("/api/products", async (req, res)=>{
    const product = new Product();
    try{
        const products = await product.getAll();
        res.send(products);
    }catch(err){
        console.log("error!!!", err.message);
        res.send(err.message);
    }

})

app.get("/api/components", async (req, res)=>{
    const component = new Component();
    try{
        const components = await component.getAll();
        res.send(components);
    }catch(err){
        console.log("error!!!", err.message);
        res.send(err.message);
    }

})

app.get("/api/categories", async (req, res)=>{
    const category = new Category();
    try{
        const categories = await category.getAll();
        res.send(categories);
    }catch(err){
        console.log("error!!!", err.message);
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
