import React from "react";
import {Switch, Route} from 'react-router-dom';
import AgendaItem from "./AgendaItem";
import AgendaItems from "./AgendaItems";

const AgendaItemsRouter = () => {
    return <Switch>
        <Route exact path="/agendaitems" component={AgendaItems}>

        </Route>
        <Route path="/agendaitems/:id" component={AgendaItem}>
        </Route>
    </Switch>
};

export default AgendaItemsRouter