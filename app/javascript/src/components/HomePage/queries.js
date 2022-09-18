import {restCall} from "../../utils/rest-helper";


function getNewsItems() {
    return restCall('newsitems').then(res => res.data)
}



function getUserBirthdays() {
    return restCall('users/birthdays').then(res => res.data)
}

function getCurrentAnnouncement() {
    return restCall('announcements/current').then(res => res.data)
}

export {getNewsItems, getUserBirthdays, getCurrentAnnouncement}