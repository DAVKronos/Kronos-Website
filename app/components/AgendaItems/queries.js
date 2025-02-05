import { restCall } from '../../utils/rest-helper'

function getAgendaitem (queryKey, id) {
  return restCall(`agendaitems/${id}`).then(res => res.data)
}

function createAgendaitem (data) {
  return restCall('agendaitems', { method: 'POST', data: { agendaitem: data } }).then(res => res.data)
}

function updateAgendaitem (id, data) {
  return restCall(`agendaitems/${id}`, { method: 'PUT', data: { agendaitem: data } }).then(res => res.data)
}

function getAgendaitems (queryKey, params = null) {
  if (params) {
    const { year, month } = params
    return restCall('agendaitems', {
      method: 'GET',
      params: { 'date[year]': year, 'date[month]': month + 1 }
    }).then(res => res.data)
  }
  return restCall('agendaitems', { method: 'GET' }).then(res => res.data)
}

function getAgendaitemType (queryKey, id) {
  return restCall(`agendaitemtypes/${id}`).then(res => res.data)
}

function getAgendaitemTypes () {
  return restCall('agendaitemtypes').then(res => res.data)
}

function getAgendaitemEvents (queryKey, id) {
  return restCall(`agendaitems/${id}/events`).then(res => res.data)
}

function getEventType (id) {
  return restCall(`eventtypes/${id}`).then(res => res.data)
}

function getCommissionForUser (queryKey, userId) {
  return restCall(`users/${userId}/commissions`).then(res => res.data)
}

function removeAgendaitem (id) {
  return restCall(`agendaitems/${id}`, {}, 'delete').then(res => res.data)
}

function getSubscriptions (queryKey, agendaitemId) {
  return restCall(`agendaitems/${agendaitemId}/subscriptions`).then(res => res.data)
}

function createSubscription (agendaItemId, data) {
  return restCall(`agendaitems/${agendaItemId}/subscriptions/`, { method: 'POST', data: { subscription: data } }).then(res => res.data)
}

function removeSubscription (agendaItemId, id) {
  return restCall(`agendaitems/${agendaItemId}/subscriptions/${id}`, {}, 'delete').then(res => res.data)
}

function getEventTypes (queryKey, agendaItemTypeId) {
  return restCall(`agendaitemtypes/${agendaItemTypeId}/eventtypes`).then(res => res.data)
}

function createEvent (agendaItemId, data) {
  return restCall(`agendaitems/${agendaItemId}/events/`, { method: 'POST', data: { event: data } }).then(res => res.data)
}

function deleteEvent (agendaItemId, id) {
  return restCall(`agendaitems/${agendaItemId}/events/${id}`, { method: 'delete' })
}

export {
  getAgendaitem,
  getAgendaitems,
  getAgendaitemType,
  getAgendaitemTypes,
  getAgendaitemEvents,
  createAgendaitem,
  updateAgendaitem,
  getCommissionForUser,
  removeAgendaitem,
  getSubscriptions,
  removeSubscription,
  createSubscription,
  getEventTypes,
  createEvent,
  deleteEvent
}
