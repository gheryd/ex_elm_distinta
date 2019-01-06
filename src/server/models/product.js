const {createAxiosInstance} = require("../utils/model_utils");

const axios = createAxiosInstance();

class Product {

    getAll(){
        return axios.get("/product").then(
            res=>{
                return res.data
            }
        );
    }

}

module.exports = Product