import React from "react";
import {Switch, Route} from 'react-router-dom';
import AgendaItem from "./AgendaItem";
import AgendaItems from "./AgendaItems";
import PrivateRoute from "../PrivateRoute";
import NewAgendaItem from "./NewAgendaItem";
import EditAgendaItem from "./EditAgendaItem";

const AgendaItemsRouter = () => {
    return <Switch>
        <Route exact path="/agendaitems" component={AgendaItems} />
        <PrivateRoute path="/agendaitems/new" component={NewAgendaItem} />
        <PrivateRoute path="/agendaitems/:id/edit" component={EditAgendaItem} />
        <Route path="/agendaitems/:id" component={AgendaItem} />


    </Switch>
};

export default AgendaItemsRouter