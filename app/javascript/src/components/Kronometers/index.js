import React from "react";
import {Route, Switch} from "react-router-dom";

import Kronometers from "./Kronometers";

const KronometerRouter = () => {
    return <Switch>
        <Route exact path="/kronometers" component={Kronometers} />
        <Route path="/kronometers/:folder_id" component={Kronometers} />

    </Switch>
};

export default KronometerRouter;