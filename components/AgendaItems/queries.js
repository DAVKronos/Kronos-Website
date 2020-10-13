import {restCall} from "../../utils/rest-helper";

function getAgendaitem(queryKey, id) {
    return restCall(`agendaitems/${id}`).then(res => res.data)
}

function getAgendaitems(queryKey, {year, month}) {
    return restCall('agendaitems', {params: {'date[year]': year, 'date[month]': month+1}}).then(res => res.data)
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


export {getAgendaitem, getAgendaitems, getAgendaitemType, getAgendaitemTypes, getAgendaitemEvents}