import {restCall} from "../../utils/rest-helper";

function getAgendaitem(queryKey, id) {
    return restCall(`agendaitems/${id}`).then(res => res.data)
}

function createAgendaitem(data) {
    return restCall(`agendaitems`, {method: 'POST', data: {agendaitem: data}}).then(res => res.data)
}

function updateAgendaitem(id, data) {
    return restCall(`agendaitems/${id}`, {method: 'PUT', data: {agendaitem: data}}).then(res => res.data)
}

function getAgendaitems(queryKey, params=null) {
    if (params) {
        const {year, month} = params;
        return restCall('agendaitems', {method: 'GET', params: {'date[year]': year, 'date[month]': month+1}}).then(res => res.data)
    }
    return restCall('agendaitems', {method: 'GET'}).then(res => res.data)
}

function getAgendaitemType(queryKey, id) {
    return restCall(`agendaitemtypes/${id}`).then(res => res.data)
}

function getAgendaitemTypes() {
    return restCall('agendaitemtypes').then(res => res.data)
}

function getAgendaitemEvents(queryKey, id) {
    return restCall(`agendaitems/${id}/events`).then(response => {
        return Promise.all(response.data.map(async event  => {
            let {name, formula, measuringunit, shortname, calculated_unit} = await getEventType(event.eventtype_id)
            return {...event, name, formula, measuringunit, shortname, calculated_unit};

        }));
    });
}

function getEventType(id) {
    return restCall(`eventtypes/${id}`).then(res => res.data)
}

function getCommissionForUser(queryKey, userId) {
    return restCall(`users/${userId}/commissions`).then(res => res.data)
}


export {getAgendaitem, getAgendaitems, getAgendaitemType, getAgendaitemTypes, getAgendaitemEvents, createAgendaitem, updateAgendaitem, getCommissionForUser}