import {restCall} from "../../utils/rest-helper";


function getUnapprovedNewsItems() {
    return restCall('newsitems/agree').then(res => res.data)
}

export {
    getUnapprovedNewsItems
}