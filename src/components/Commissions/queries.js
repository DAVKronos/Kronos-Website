import {restCall} from "../../utils/rest-helper";


function getCommission(queryKey, id) {
    return restCall(`commissions/${id}`).then(res => res.data)
}

function getUsersForCommission(queryKey, id) {
    return getCommission(queryKey, id).then(commission => {
        if (commission.commission_memberships){
            return commission.commission_memberships.map(v => ({id: v.user_id, name: v.user.name}));
        }
        return []
    })
}

function getCommissions() {
    return restCall('commissions').then(res => res.data)
}

export {getCommission, getCommissions, getUsersForCommission}