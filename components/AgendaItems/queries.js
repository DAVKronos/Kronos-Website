import {restCall} from "../../utils/rest-helper";

function getAgendaitem(queryKey, id) {
    return restCall(`agendaitems/${id}`).then(res => res.data)
}

function getAgendaitems() {
    return restCall('agendaitems').then(res => res.data)
}

function getAgendaitemType(queryKey, id) {
    return restCall(`agendaitemtypes/${id}`).then(res => res.data)
}

function getAgendaitemTypes() {
    return restCall('agendaitemtypes').then(res => res.data)
}

export {getAgendaitem, getAgendaitems, getAgendaitemType, getAgendaitemTypes}