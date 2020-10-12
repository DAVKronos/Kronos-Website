import {restCall} from "../../utils/rest-helper";


function getNewsItem(queryKey, id) {
    return restCall(`newsitems/${id}`).then(res => res.data)
}


export {getNewsItem}