import React from "react";
import {Switch} from 'react-router-dom';
import PrivateRoute from "../Generic/PrivateRoute";
import Users from "./Users";
import User from "./User";

const UsersRouter = () => {
    return <Switch>
        <PrivateRoute action={'read'} subject={'User'} exact path="/users" component={Users} />
        <PrivateRoute action={'read'} subject={'User'} path="/users/:id" component={User} />
    </Switch>
};

export default UsersRouter