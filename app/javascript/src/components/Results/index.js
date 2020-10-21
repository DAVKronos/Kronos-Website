import React from "react";
import {Switch, Route} from 'react-router-dom';
import Results from "./Results";

const ResultsRouter = () => {
    return <Switch>
        <Route exact path="/results" component={Results}>

        </Route>
    </Switch>
};

export default ResultsRouter