import {restCall} from "../../utils/rest-helper";


function getPhotoAlbums() {
    return restCall(`photoalbums`).then(res => res.data)
}

function getPhotoAlbum(queryKey, id) {
    return restCall(`photoalbums/${id}`).then(res => res.data)
}



export {getPhotoAlbums, getPhotoAlbum}