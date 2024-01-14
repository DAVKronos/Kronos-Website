import { restCall } from '../../utils/rest-helper'
import { getLocalSettings } from '../../utils/local-settings'

function getNewsItems () {
  return restCall('newsitems').then(res => res.data)
}

function getUserBirthdays () {
  return restCall('users/birthdays').then(res => res.data)
}

function getCurrentAnnouncement () {
  const hidden_ids = getLocalSettings('hiddenAnnouncements') || []

  return restCall('announcements/current', { params: { hidden_ids } }).then(res => res.data)
}

export { getNewsItems, getUserBirthdays, getCurrentAnnouncement }
