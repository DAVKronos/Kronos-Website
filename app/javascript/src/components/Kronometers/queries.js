import { restCall, convertToFormData } from '../../utils/rest-helper'

function getKronometers(queryKey) {
  return restCall('kronometers').then((res) => res.data)
}

function getFolders(queryKey) {
  return restCall('folders').then((res) => res.data)
}

function getFoldersWithoutId(queryKey, folder_id) {
  return restCall(`folders/${folder_id}/folders`).then((res) => res.data)
}

function getFolderById(queryKey, folder_id) {
  return restCall(`folders/${folder_id}`).then((res) => res.data)
}

function getKronometersByFolder(queryKey, folder_id) {
  return restCall(`folders/${folder_id}/kronometers`).then((res) => res.data)
}

function getKronometerById(queryKey, kronometerId) {
  return restCall(`kronometers/${kronometerId}`).then((res) => res.data)
}

function createFolder(data) {
  return restCall('folders', {
    method: 'POST',
    data: { folder: data }
  }).then((res) => res.data)
}

function updateFolder(id, data) {
  return restCall(`folders/${id}`, {
    method: 'PUT',
    data: { folder: data }
  }).then((res) => res.data)
}

function removeFolder(id) {
  return restCall(`folders/${id}`, { method: 'DELETE' })
}

function createKronometer(data) {
  const formData = convertToFormData('kronometer', data)
  return restCall('kronometers', {
    method: 'POST',
    data: formData
  }).then((res) => res.data)
}

function updateKronometer(id, data) {
  return restCall(`kronometers/${id}`, {
    method: 'PUT',
    data: { kronometer: data }
  }).then((res) => res.data)
}

function removeKronometer(id) {
  return restCall(`kronometers/${id}`, { method: 'DELETE' })
}

export {
  getKronometers,
  getFolders,
  getFolderById,
  getFoldersWithoutId,
  getKronometersByFolder,
  getKronometerById,
  createFolder,
  updateFolder,
  removeFolder,
  createKronometer,
  updateKronometer,
  removeKronometer
}
