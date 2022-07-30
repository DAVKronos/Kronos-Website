import axios from 'axios';
import {getAuthDetails} from "./auth-helper";

const API_HOST = '/api/v1';

const config = {
    headers: { 'Accept': 'application/json'},
};


function convertToFormData(objectName, data){
    const formData = new FormData();
    Object.keys(data).forEach((field) => {
        if (data[field] != undefined || data[field] != null) {
            formData.append(`${objectName}[${field}]`, data[field]);
        }
    })
    return formData
}

function getAuthHeader() {
    return getAuthDetails() || {};
}

function getConfig() {
    let cfg = {...config}
    cfg.headers = {...cfg.headers, ...getAuthHeader()};
    return cfg;
}


function restCall(url, params = {}, method='get') {
    return axios.request({...getConfig(), url:`${API_HOST}/${url}`, method,  ...params});
}


function getAPIHostUrl(url) {
    return url;
}


export {
    restCall,
    API_HOST,
    getAPIHostUrl,
    getConfig,
    convertToFormData
}