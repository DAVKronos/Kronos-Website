import React, { useContext } from 'react';
import { Route, Redirect } from 'react-router-dom';
import {ability} from "../../utils/auth-helper";

const PrivateRoute = ({ component: Component, action, subject, field, ...rest }) => {
    const isAllowed = ability.can(action, subject, field);
    return (
        <Route
            {...rest}
            render={(routeProps) => (
                isAllowed ? <Component {...routeProps} /> : <Redirect to="/" />
            )}
        />

    );
    /*  we are spreading routeProps to be able to access this routeProps in the component. */
};

export default PrivateRoute;