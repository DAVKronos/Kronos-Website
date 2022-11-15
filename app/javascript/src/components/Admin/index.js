import React from 'react'
import { Switch, Route } from 'react-router-dom'
import AdminHome from './AdminHome'
import ApproveNews from './ApproveNews'
import Pages from './Pages'
import MailingListRouter from '../MailingLists'
import AliasRouter from '../Aliases'
import AnnouncementRouter from '../Announcements'

const AdminRouter = () => {
  return (
    <Switch>
      <Route exact path='/admin' component={AdminHome} />
      <Route exact path='/admin/approve-news' component={ApproveNews} />
      <Route exact path='/admin/pages' component={Pages} />
      <Route path='/admin/mailinglists'>
        <MailingListRouter />
      </Route>
      <Route path='/admin/aliases'>
        <AliasRouter />
      </Route>
      <Route path='/admin/announcements'>
        <AnnouncementRouter />
      </Route>
      <Route exact path='/admin/objects' component={AdminHome} />

    </Switch>
  )
}

export default AdminRouter
