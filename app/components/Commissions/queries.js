import { restCall } from '../../utils/rest-helper'

function getCommission (queryKey, id) {
  return restCall(`commissions/${id}`).then((res) => res.data)
}

function getUsersForCommission (queryKey, id) {
  return getCommission(queryKey, id).then((commission) => {
    if (commission.commission_memberships) {
      return commission.commission_memberships.map((v) => ({
        id: v.user_id,
        name: v.user.name
      }))
    }
    return []
  })
}

function getCommissions () {
  return restCall('commissions').then((res) => res.data)
}

function getCommissionMemberships (queryKey, commissionId, otherKey) {
  return restCall(`commissions/${commissionId}/commission_memberships`).then(
    (res) => res.data
  )
}

function createCommission (data) {
  return restCall('commissions', {
    method: 'POST',
    data: { commission: data }
  }).then((res) => res.data)
}

function createCommissionMembership (commissionId, data) {
  return restCall(`commissions/${commissionId}/commission_memberships`, {
    method: 'POST',
    data: { commission_membership: data }
  }).then((res) => res.data)
}

function updateCommission (id, data) {
  return restCall(`commissions/${id}`, {
    method: 'PUT',
    data: { commission: data }
  }).then((res) => res.data)
}

function removeCommision (id) {
  return restCall(`commissions/${id}`, { method: 'DELETE' })
}

function removeCommissionMembership (id, membershipId) {
  return restCall(`commissions/${id}/commission_memberships/${membershipId}`, { method: 'DELETE' })
}

export {
  getCommission,
  getCommissions,
  getCommissionMemberships,
  getUsersForCommission,
  createCommission,
  updateCommission,
  removeCommision,
  createCommissionMembership,
  removeCommissionMembership
}
