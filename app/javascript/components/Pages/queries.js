import {restCall} from "../../utils/rest-helper";


function getPage(queryKey, id) {
    return restCall(`pages/${id}`).then(res => res.data)
}

function getPageByPageTag(queryKey, pagetag) {
    return restCall('pages').then(res => {
        return res.data.find(page => page.pagetag.indexOf(pagetag) > -1)
    });
}

export {getPage, getPageByPageTag}