import {restCall} from "../../utils/rest-helper";

function getMemberships(querykey, userId) {
    return restCall(`users/${userId}/commissions`).then(res => res.data)
}
function getUsers(queryKey) {
    return restCall('users').then(res => res.data)
}

function getUser(queryKey, id) {
    return restCall(`users/${id}`).then(res => res.data)
}

function getUserType(queryKey, id) {
    return restCall(`user_types/${id}`).then(res => res.data)
}

function getUserTypes() {
    return restCall('user_types').then(res => res.data)
}



export {
    getMemberships,
    getUser,
    getUsers,
    getUserType,
    getUserTypes
}