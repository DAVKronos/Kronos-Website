import React from 'react'
import { Switch, Route } from 'react-router-dom'
import UserTypes from './UserTypes'

const UserTypesRouter = () => {
  return (
    <Switch>
      <Route exact path='/usertypes' component={UserTypes} />
    </Switch>
  )
}

export default UserTypesRouter
