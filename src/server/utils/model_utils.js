const axios = require("axios");

function createAxiosInstance(){
    return axios.create({
        baseURL: 'http://localhost:3000',
        timeout: 20000
    });
}

module.exports = {createAxiosInstance};