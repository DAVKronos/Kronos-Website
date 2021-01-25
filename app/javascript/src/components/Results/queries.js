import {restCall} from "../../utils/rest-helper";


function getResults(queryKey, {year, month}) {
    return restCall('results', {params: {'date[year]': year, 'date[month]': month + 1}}).then(res => res.data)
}

function createResult(eventId, data) {
    return restCall(`results`, {data: {result: {...data, event_id: eventId}}, method: "POST"}).then(res => res.data)
}


export {getResults, createResult}