import React from 'react'
import { Switch, Route } from 'react-router-dom'
import Announcements from './Announcements'
import PrivateRoute from '../Generic/PrivateRoute'
import EditAnnouncement from './EditAnnouncement'
import NewAnnouncement from './NewAnnouncement'

const AnnouncementRouter = () => {
  return (
    <Switch>
      <PrivateRoute exact path='/admin/announcements' component={Announcements} action='read' subject='Announcement' />
      <PrivateRoute path='/admin/announcements/new' component={NewAnnouncement} action='create' subject='Announcement' />
      <PrivateRoute path='/admin/announcements/:id/edit' component={EditAnnouncement} action='update' subject='Announcement' />

    </Switch>
  )
}

export default AnnouncementRouter
