import React from "react";
import {Switch} from 'react-router-dom';
import PrivateRoute from "../PrivateRoute";
import Users from "./Users";
import User from "./User";

const UsersRouter = () => {
    return <Switch>
        <PrivateRoute exact path="/users" component={Users} />
        <PrivateRoute exact path="/users/:id" component={User} />
    </Switch>
};

export default UsersRouter