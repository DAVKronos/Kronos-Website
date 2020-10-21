import {restCall} from "../../utils/rest-helper";


function getPages() {
    return restCall('pages').then(res => res.data)
}

export {getPages}