import React from 'react'
import { Switch, Route } from 'react-router-dom'
import PrivateRoute from '../Generic/PrivateRoute'
import Aliases from './Aliases'
import EditAlias from './EditAlias'
import NewAlias from './NewAlias'

const AliasRouter = () => {
  return (
    <Switch>
      <PrivateRoute
        path='/admin/aliases/new'
        component={NewAlias}
        action='create'
        subject='Alias'
      />
      <PrivateRoute
        path='/admin/aliases/:id/edit'
        component={EditAlias}
        action='update'
        subject='Alias'
      />
      <PrivateRoute
        exact
        path='/admin/aliases'
        component={Aliases}
        action='read'
        subject='Alias'
      />
    </Switch>
  )
}

export default AliasRouter
