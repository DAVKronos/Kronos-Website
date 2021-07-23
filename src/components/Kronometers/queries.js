import {restCall} from "../../utils/rest-helper";

function getKronometers(queryKey) {
    return restCall(`kronometers/`).then(res => res.data)
}

function getFolders(queryKey) {
    return restCall(`folders`).then(res => res.data)
}

function getFolderById(queryKey, folder_id) {
    return restCall(`folders/${folder_id}`).then(res => res.data)
}

function getKronometersByFolder(queryKey, folder_id) {
    return restCall(`folders/${folder_id}/kronometers`).then(res => res.data)
}


export {getKronometers, getFolders,getFolderById, getKronometersByFolder}