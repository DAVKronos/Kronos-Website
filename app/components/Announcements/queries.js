import { restCall, convertToFormData } from '../../utils/rest-helper'

function getAnnouncement (queryKey, id) {
  return restCall(`announcements/${id}`).then(res => res.data)
}

function getAnnouncements (queryKey) {
  return restCall('announcements').then(res => res.data)
}

function createAnnouncement (data) {
  const formData = convertToFormData('announcement', data)
  return restCall('announcements/', { method: 'POST', data: formData }).then(res => res.data)
}

function updateAnnouncement (id, data) {
  const formData = convertToFormData('announcement', data)
  return restCall(`announcements/${id}`, { method: 'PUT', data: formData }).then(res => res.data)
}

function removeAnnouncement (id) {
  return restCall(`announcements/${id}`, { method: 'DELETE' })
}

export { getAnnouncement, getAnnouncements, createAnnouncement, updateAnnouncement, removeAnnouncement }
