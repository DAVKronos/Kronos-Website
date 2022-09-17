import axios from "axios";
import {getConfig, restCall} from './rest-helper'
import {Ability} from "@casl/ability";
import {createCanBoundTo} from '@casl/react';

function getAbilities() {
    return restCall('abilities').then(res => res.data);
}

function updateAbilities(ability) {
    return getAbilities().then(rules => {
        ability.update(rules);
        return rules
    })
}

function initializeAbilities() {
    const ability = new Ability()
    updateAbilities(ability);
    return ability
}

function getAuthentication() {
    if (!localStorage.getItem('kronos-auth')) {
        return null;
    }
    return JSON.parse(localStorage.getItem('kronos-auth'));
}

async function validateToken() {
    if (!localStorage.getItem('kronos-auth')) {
        return null;
    }
    const {uid, client} = authDetails;
    const access_token = authDetails['access-token']
    return axios.get(`/api/v1/auth/validate_token?uid=${uid}&client=${client}&access-token=${access_token}`).then(response => {
        const user = response.data.data;
        return updateAbilities(ability).then(() => {
            return user;
        });
    }, (error)=> {
        localStorage.removeItem('kronos-auth')
        return null;
    })
}

let authDetails = getAuthentication();
const ability = initializeAbilities();

function getAuthDetails(){
    return Object.freeze(authDetails);
}

function setAuthDetails(obj){
    authDetails = obj;
}

function login(email, password, rememberMe) {
    return axios.post(`/api/v1/auth/sign_in`, {email, password}, getConfig())
        .then((response) => {
            let auth_data = {};
            let user = response.data.data;
            auth_data['access-token'] = response.headers['access-token'];
            auth_data['client'] = response.headers['client'];
            auth_data['uid'] = user.uid;
            if (rememberMe) {
                localStorage.setItem('kronos-auth', JSON.stringify(auth_data));
            }
            setAuthDetails(auth_data);
            return updateAbilities(ability).then(() => {

                return user;
            });
        })
        .catch(() => {
            return undefined;
        });
}

function logout() {
    return axios.delete(`/api/v1/auth/sign_out`, {...getConfig()})
        .then(() => {
            localStorage.removeItem('kronos-auth');
            setAuthDetails(null);
            return updateAbilities(ability);
        })
        .catch(() => {
            return undefined;
        });

}

function forgotPassword(email) {
    if (localStorage.getItem('kronos-auth')) {
        localStorage.removeItem('kronos-auth')
    }
    
    
    return axios.post(`/api/v1/auth/password`, {email, redirect_url: '/app/users/reset_password'}, getConfig())

} 

function changePassword(password, password_confirmation) {
    return axios.put('/api/v1/auth/password', {password, password_confirmation}, getConfig())
}

function resetPassword(password, password_confirmation, uid, client, access_token) {
    const config = getConfig();
    config.headers = {...config.headers, 'access-token': access_token, uid, client}
    return axios.put('/api/v1/auth/password', {password, password_confirmation}, config)
}

const Can = createCanBoundTo(ability);


export {
    login,
    logout,
    ability,
    Can,
    validateToken,
    getAuthDetails,
    forgotPassword,
    resetPassword,
    changePassword
}