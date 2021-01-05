import React from "react";
import {Switch, Route} from 'react-router-dom';
import AgendaItemTypes from "./AgendaItemTypes";
import EditAgendaItemType from './EditAgendaItemType';
import NewAgendaItemType from './NewAgendaItemType';
import PrivateRoute from "../Generic/PrivateRoute";

const AgendaItemTypesRouter = () => {
    return <Switch>
        <Route exact path="/agendaitemtypes" component={AgendaItemTypes} />
        <PrivateRoute action='create'
                      subject="Agendaitemtype"
                      path="/agendaitemtypes/new"
                      component={NewAgendaItemType} />
        <PrivateRoute action='update'
                      subject='Agendaitemtype'
                      path="/agendaitemtypes/:id/edit"
                      component={EditAgendaItemType} />

    </Switch>
};

export default AgendaItemTypesRouter