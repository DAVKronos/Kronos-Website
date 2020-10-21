import React from "react";
import {Switch, Route} from 'react-router-dom';
import NewsItems from "../HomePage/HomePageNewsItems";
import NewsItem from "./NewsItem";

const NewsItemsRouter = () => {
    return <Switch>
        <Route exact path="/newsitems" component={NewsItems} />
        <Route path="/newsitems/:id" component={NewsItem} />
    </Switch>
};

export default NewsItemsRouter