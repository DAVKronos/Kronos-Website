import React from 'react'
import { Route, Switch } from 'react-router-dom'

import Kronometers from './Kronometers'
import PrivateRoute from '../Generic/PrivateRoute'
import NewKronometer from './NewKronometer'
import EditKronometer from './EditKronometer'

const KronometerRouter = () => {
  return (
    <Switch>
      <Route exact path='/kronometers' component={Kronometers} />

      <PrivateRoute
        path='/kronometers/new'
        component={NewKronometer}
        action='create'
        subject='Kronometer'
      />
      <PrivateRoute
        path='/kronometers/:parentid/new'
        component={NewKronometer}
        action='create'
        subject='Kronometer'
      />
      <PrivateRoute
        path='/kronometers/:id/edit'
        component={EditKronometer}
        action='update'
        subject='Kronometer'
      />
      <Route path='/kronometers/:folder_id' component={Kronometers} />
    </Switch>
  )
}

export default KronometerRouter
