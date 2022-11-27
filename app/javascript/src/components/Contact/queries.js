import { convertToFormData, restCall } from '../../utils/rest-helper'

function createContactMessage (data) {
  return restCall('contact/', { method: 'POST', data: { contact: data } }).then(res => res.data)
}

export {
  createContactMessage
}
