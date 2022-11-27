import React from 'react'
import { Switch, Route } from 'react-router-dom'
import PrivateRoute from '../Generic/PrivateRoute'
import Users from './Users'
import User from './User'
import EditUser from './EditUser'
import NewUser from './NewUser'
import ForgotPasswordPage from './ForgotPassword'
import ResetPassword from './ResetPassword'
import ChangePassword from './ChangePassword'

const UsersRouter = () => {
  return (
    <Switch>
      <PrivateRoute action='read' subject='User' exact path='/users' component={Users} />
      <Route exact path='/users/forgot_password' component={ForgotPasswordPage} />
      <Route exact path='/users/reset_password' component={ResetPassword} />
      <PrivateRoute action='create' subject='User' path='/users/new' component={NewUser} />
      <PrivateRoute action='editpassword' subject='User' path='/users/:id/password/edit' component={ChangePassword} />
      <PrivateRoute action='update' subject='User' path='/users/:id/edit' component={EditUser} />
      <PrivateRoute action='read' subject='User' path='/users/:id' component={User} />
    </Switch>
  )
}

export default UsersRouter
