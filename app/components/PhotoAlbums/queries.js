import { convertToFormData, restCall } from '../../utils/rest-helper'

function getPhotoAlbums () {
  return restCall('photoalbums').then(res => res.data)
}

function getPhotoAlbum (queryKey, id) {
  return restCall(`photoalbums/${id}`).then(res => res.data)
}

function createPhotoAlbum (data) {
  return restCall('photoalbums/', { method: 'POST', data: { photoalbum: data } }).then(res => res.data)
}

function updatePhotoAlbum (id, data) {
  return restCall(`photoalbums/${id}`, { method: 'PUT', data: { photoalbum: data } }).then(res => res.data)
}

function removePhotoAlbum (id) {
  return restCall(`photoalbums/${id}`, { method: 'DELETE' }).then(res => res.data)
}

function getPhotos (queryKey, photoAlbumId) {
  return restCall(`photoalbums/${photoAlbumId}/photos`).then(res => res.data)
}

async function addPhotosToAlbums (photoAlbumId, photos, progressCallBack) {
  const total = photos.length

  for (const photo of [...photos]) {
    const idx = [...photos].indexOf(photo)
    const formData = convertToFormData('photo', { photo })
    const onUploadProgress = (e) => {
      if (e.lengthComputable) {
        progressCallBack({ loaded: idx + 0.9 * (e.loaded / e.total), total })
      }
    }
    await restCall(`photoalbums/${photoAlbumId}/photos`, { method: 'POST', data: formData, onUploadProgress }).then(() => {
      progressCallBack({ loaded: idx + 1, total })
    })
  }
  return Promise.resolve()
}

function deletePhoto (photoAlbumId, photoId) {
  return restCall(`photoalbums/${photoAlbumId}/photos/${photoId}`, { method: 'DELETE' }).then(res => res.data)
}

export { getPhotoAlbums, getPhotoAlbum, createPhotoAlbum, updatePhotoAlbum, removePhotoAlbum, getPhotos, addPhotosToAlbums, deletePhoto }
