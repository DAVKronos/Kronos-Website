import {restCall} from "../../utils/rest-helper";


function getCommission(queryKey, id) {
    return restCall(`commissions/${id}`).then(res => res.data)
}

function getCommissions() {
    return restCall('commissions').then(res => res.data)
}

export {getCommission, getCommissions}