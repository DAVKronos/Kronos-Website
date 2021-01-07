import {restCall} from "../../utils/rest-helper";


function getPhotoAlbums() {
    return restCall(`photoalbums`).then(res => res.data)
}

function getPhotoAlbum(queryKey, id) {
    return restCall(`photoalbums/${id}`).then(res => res.data)
}

function createPhotoAlbum(data) {
    return restCall(`photoalbums/`, {method: "POST", data:{photoalbum:data}}).then(res => res.data);
}

function updatePhotoAlbum(id, data) {
    return restCall(`photoalbums/${id}`, {method: "PUT", data:{photoalbum:data }}).then(res => res.data);
}

function removePhotoAlbum(id) {
    return restCall(`photoalbums/${id}`, {method: "DELETE"}).then(res => res.data);
}

function addPhotosToAlbums(photoAlbumId, data) {

}



export {getPhotoAlbums, getPhotoAlbum, createPhotoAlbum, updatePhotoAlbum, removePhotoAlbum}