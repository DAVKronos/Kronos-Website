import axios from "axios";
import {getConfig} from './rest-helper'
function login(email, password) {
    return axios.post(`/api/v1/auth/sign_in`, {email, password}, getConfig())
        .then((response) => {
            let user = response.data.data;
            user['access-token'] = response.headers['access-token'];
            user['client'] = response.headers['client'];
            sessionStorage.setItem('user', JSON.stringify(user));
            return user;
        })
        .catch(() => {
            return undefined;
        });
}

function logout() {
    return axios.delete(`/api/v1/auth/sign_out`, {...getConfig()})
        .then(() => {
            sessionStorage.removeItem("user");
        })
        .catch(() => {
            return undefined;
        });

}


function getCurrentUser() {
    return JSON.parse(sessionStorage.getItem('user'));
}



export {
    login,
    logout,
    getCurrentUser
}