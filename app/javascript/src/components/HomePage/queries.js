import {restCall} from "../../utils/rest-helper";


function getNewsItems() {
    return restCall('newsitems').then(res => res.data)
}

function getAgendaItems() {
    return restCall('agendaitems').then(res => res.data)
}


function getUserBirthdays() {
    return restCall('users/birthdays').then(res => res.data)
}

export {getNewsItems, getAgendaItems, getUserBirthdays}