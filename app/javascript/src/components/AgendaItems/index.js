import React from "react";
import {Switch, Route} from 'react-router-dom';
import AgendaItem from "./AgendaItem";
import AgendaItems from "./AgendaItems";
import PrivateRoute from "../Generic/PrivateRoute";
import NewAgendaItem from "./NewAgendaItem";
import EditAgendaItem from "./EditAgendaItem";

const AgendaItemsRouter = () => {
    return <Switch>
        <Route exact path="/agendaitems" component={AgendaItems} />
        <PrivateRoute action="create" subject='Agendaitem' path="/agendaitems/new" component={NewAgendaItem} />
        <PrivateRoute action="update" subject='Agendaitem' path="/agendaitems/:id/edit" component={EditAgendaItem} />
        <Route path="/agendaitems/:id" component={AgendaItem} />


    </Switch>
};

export default AgendaItemsRouter