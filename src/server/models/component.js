const {createAxiosInstance} = require("../utils/model_utils");
const axios = createAxiosInstance();

class Component {
    getAll(){
        return axios.get("/component").then(
            res=>{
                return res.data
            }
        );
    }
}

module.exports = Component