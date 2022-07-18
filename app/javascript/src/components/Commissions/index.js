import React from "react";
import { Switch, Route } from "react-router-dom";
import Commission from "./Commission";
import Commissions from "./Commissions";
import EditCommission from "./EditCommissions";
import NewCommission from "./NewCommission";
import PrivateRoute from "../Generic/PrivateRoute";

const CommissionsRouter = () => {
  return (
    <Switch>
      <Route exact path="/commissions" component={Commissions}></Route>
      <PrivateRoute
        path="/commissions/new"
        component={NewCommission}
        action={"create"}
        subject="Commission"
      />
      <PrivateRoute
        path="/commissions/:id/edit"
        component={EditCommission}
        action={"update"}
        subject="Commission"
      />
      <Route path="/commissions/:id" component={Commission}></Route>
    </Switch>
  );
};

export default CommissionsRouter;
