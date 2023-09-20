import React from 'react'
import { Route, Switch } from 'react-router-dom'
import NewFolder from './NewFolder'
import EditFolder from './EditFolder'
import PrivateRoute from '../../Generic/PrivateRoute'

const FolderRouter = () => {
  return (
    <Switch>
      <PrivateRoute
        path='/folders/new'
        component={NewFolder}
        action='create'
        subject='Folder'
      />
      <PrivateRoute
        path='/folders/:parentid/new'
        component={NewFolder}
        action='create'
        subject='Folder'
      />
      <PrivateRoute
        path='/folders/:id/edit'
        component={EditFolder}
        action='update'
        subject='Folder'
      />
    </Switch>
  )
}

export default FolderRouter
