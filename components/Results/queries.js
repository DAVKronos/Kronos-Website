import {restCall} from "../../utils/rest-helper";


function getResults(queryKey, {year, month}) {
    return restCall('results', {params: {'date[year]': year, 'date[month]': month + 1}}).then(res => res.data)
}



export {getResults}