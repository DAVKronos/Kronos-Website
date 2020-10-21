import {restCall} from "../../utils/rest-helper";


function getUsers(queryKey) {
    return restCall('users').then(res => res.data)
}

function getUser(queryKey, id) {
    return restCall(`users/${id}`).then(res => res.data)
}



export {getUser, getUsers}