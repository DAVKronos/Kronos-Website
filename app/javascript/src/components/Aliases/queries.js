import { restCall } from '../../utils/rest-helper'

function getAliases () {
  return restCall('aliases').then((res) => res.data)
}

function getAlias (queryKey, id) {
  return restCall(`aliases/${id}`).then((res) => res.data)
}

function createAlias (data) {
  return restCall('aliases', { method: 'POST', data: { alias: data } }).then(
    (res) => res.data
  )
}

function updateAlias (id, data) {
  return restCall(`aliases/${id}`, {
    method: 'PUT',
    data: { alias: data }
  }).then((res) => res.data)
}

function removeAlias (id) {
  return restCall(`aliases/${id}`, { method: 'DELETE' })
}

export { getAliases, getAlias, createAlias, updateAlias, removeAlias }
