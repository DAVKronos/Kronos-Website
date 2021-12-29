import React from "react";
import {Switch, Route} from 'react-router-dom';
import NewsItems from "./NewsItems";
import NewsItem from "./NewsItem";
import PrivateRoute from "../Generic/PrivateRoute";
import EditNewsItem from './EditNewsItem';
import NewNewsItem from './NewNewsItem';

const NewsItemsRouter = () => {
    return <Switch>
        <Route exact path="/newsitems" component={NewsItems} />
        <PrivateRoute action='create' subject='Newsitem' exact path="/newsitems/new" component={NewNewsItem}/>
        <PrivateRoute action='update' subject='Newsitem' path="/newsitems/:id/edit" component={EditNewsItem}/>
        <Route path="/newsitems/:id" component={NewsItem} />

    </Switch>
};

export default NewsItemsRouter