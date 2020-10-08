import React from "react";
import {Switch, Route} from 'react-router-dom';
import Page from "./Page";

// TODO PageId should be accesed by id or pagetag.
const PhotoAlbumsRouter = () => {
    return <Switch>
        <Route path="/pages/:id" component={Page} />
        <Route path="/:pagetag"  render={(routeProps) => {
            // Key is to rerender when switching to a new page
            return <Page key={routeProps.match.params.pagetag} {...routeProps}/>;
        }} />
    </Switch>
};

export default PhotoAlbumsRouter