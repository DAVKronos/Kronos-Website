import React from "react";
import {Switch, Route} from 'react-router-dom';
import Commission from "./Commission";
import Commissions from "./Commissions";

const CommissionsRouter = () => {
    return <Switch>
        <Route exact path="/commissions" component={Commissions}>

        </Route>
        <Route path="/commissions/:id" component={Commission}>
        </Route>
    </Switch>
};

export default CommissionsRouter