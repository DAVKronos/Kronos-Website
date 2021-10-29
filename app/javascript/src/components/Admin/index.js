import React from "react";
import {Switch, Route} from 'react-router-dom';
import AdminHome from "./AdminHome";
import ApproveNews from "./ApproveNews";

const AdminRouter = () => {
    return <Switch>
        <Route exact path="/admin" component={AdminHome} />
        <Route exact path="/admin/approve-news" component={ApproveNews}  />
        <Route exact path="/admin/mailinglists" component={AdminHome} />
        <Route exact path="/admin/objects" component={AdminHome} />
        <Route exact path="/admin/pages" component={AdminHome} />
    </Switch>
};

export default AdminRouter