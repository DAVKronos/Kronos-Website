import React from "react";
import {Switch} from 'react-router-dom';
import PrivateRoute from "../Generic/PrivateRoute";
import Users from "./Users";
import User from "./User";
import EditUser from "./EditUser";
import NewUser from './NewUser';

const UsersRouter = () => {
    return <Switch>
        <PrivateRoute action={'read'} subject={'User'} exact path="/users" component={Users} />
        <PrivateRoute action={'create'} subject={'User'} path="/users/new" component={NewUser} />
        <PrivateRoute action={'update'} subject={'User'} path="/users/:id/edit" component={EditUser} />
        <PrivateRoute action={'read'} subject={'User'} path="/users/:id" component={User} />
    </Switch>
};

export default UsersRouter