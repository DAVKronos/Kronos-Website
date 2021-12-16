import React from "react";
import { Switch, Route } from "react-router-dom";
import PrivateRoute from "../Generic/PrivateRoute";
import EditMailingList from "./EditMailingList";
import MailingLists from "./MailingLists";
import NewMailingList from "./NewMailingList";

const MailingListRouter = () => {
  return (
    <Switch>
      <PrivateRoute
        path="/admin/mailinglists/new"
        component={NewMailingList}
        action={"create"}
        subject="Mailinglist"
      />
      <PrivateRoute
        path="/admin/mailinglists/:id/edit"
        component={EditMailingList}
        action={"update"}
        subject="Mailinglist"
      />
      <PrivateRoute
        exact
        path="/admin/mailinglists"
        component={MailingLists}
        action={"read"}
        subject="Mailinglist"
      />
    </Switch>
  );
};

export default MailingListRouter;
