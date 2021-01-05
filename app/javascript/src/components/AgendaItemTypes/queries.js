import {restCall} from "../../utils/rest-helper";


function getAgendaItemType(queryKey, id) {
    return restCall(`agendaitemtypes/${id}`).then(res => res.data)
}

function getAgendaItemTypes() {
    return restCall('agendaitemtypes').then(res => res.data)
}

function createAgendaItemType(data){
    return restCall('agendaitemtypes', {method: "POST", data: {agendaitemtype: data}}).then(res => res.data)
}

function updateAgendaItemType(id, data){
    return restCall(`agendaitemtypes/${id}`, {method: "PUT", data: {agendaitemtype: data}})
}

function deleteAgendaItemType(id){
    return restCall(`agendaitemtypes/${id}`, {method: "DELETE"})
}

export {getAgendaItemType, getAgendaItemTypes, createAgendaItemType, deleteAgendaItemType, updateAgendaItemType}