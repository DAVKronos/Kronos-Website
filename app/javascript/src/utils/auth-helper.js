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
        const user = JSON.parse(sessionStorage.getItem('user'))
        if (user) {
            user.abilities = rules;
            sessionStorage.setItem('user', JSON.stringify(user));
        }
        return rules
    })
}

function initializeAbilities() {
    const ability = new Ability()
    const user = JSON.parse(sessionStorage.getItem('user'))
    if (user && user.abilities) {
        ability.update(user.abilities);
    } else {
        updateAbilities(ability);
    }

    return ability
}

const ability = initializeAbilities();

function login(email, password) {
    return axios.post(`/api/v1/auth/sign_in`, {email, password}, getConfig())
        .then((response) => {
            let user = response.data.data;
            user['access-token'] = response.headers['access-token'];
            user['client'] = response.headers['client'];
            sessionStorage.setItem('user', JSON.stringify(user));
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
            sessionStorage.removeItem("user");
            return updateAbilities(ability);
        })
        .catch(() => {
            return undefined;
        });

}



const Can = createCanBoundTo(ability);


export {
    login,
    logout,
    ability,
    Can
}