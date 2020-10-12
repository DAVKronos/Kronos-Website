import {restCall, transformObject} from "../../utils/rest-helper";


function getNewsItems() {
    return restCall('newsitems').then(res => res.data)
}

function getAgendaItems() {
    return restCall('agendaitems').then(res => res.data)
}

export {getNewsItems, getAgendaItems}