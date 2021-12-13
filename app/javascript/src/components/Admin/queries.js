import {restCall} from "../../utils/rest-helper";


function getUnapprovedNewsItems() {
    return restCall('newsitems/agree').then(res => res.data)
}

function getAliases() {
    return restCall('aliases').then(res => res.data);
}

function getAlias(queryKey, id) {
    return restCall(`aliases/${id}`).then(res => res.data);
}

export {
    getUnapprovedNewsItems,
    getAliases,
    getAlias
}