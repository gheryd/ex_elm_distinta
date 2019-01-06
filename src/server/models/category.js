const {createAxiosInstance} = require("../utils/model_utils");

const axios = createAxiosInstance();

class Category {

    getAll(){
        return axios.get("/category").then(
            res=>{
                return res.data
            }
        );
    }

}

module.exports = Category