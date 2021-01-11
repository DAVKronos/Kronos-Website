import React from 'react';
import {
    BrowserRouter as Router,
    Switch,
    Route
} from "react-router-dom";

import Header from "./components/Header/Header";
import HomePage from "./components/HomePage/HomePage";
import NewsItemsRouter from "./components/NewsItems";
import AgendaItemsRouter from "./components/AgendaItems";
import Contact from "./components/Contact/Contact";
import PhotoAlbumsRouter from "./components/PhotoAlbums";
import CommissionsRouter from "./components/Commissions";
import ResultsRouter from "./components/Results";
import PagesRouter from "./components/Pages";
import UsersRouter from "./components/Users";
import AgendaItemTypesRouter from "./components/AgendaItemTypes";
import {Container} from 'react-bootstrap';


const AppRouter = () => {
    return <Router basename={'/app'}>
        <Container fluid="lg">
        <Header />
        <div className='main'>
            <Switch>
                <Route exact path="/">
                    <HomePage key='home' />
                </Route>
                <Route path="/newsitems">
                    <NewsItemsRouter />
                </Route>
                <Route path="/agendaitems">
                    <AgendaItemsRouter />
                </Route>
                <Route path="/contact">
                    <Contact />
                </Route>
                <Route path="/photoalbums">
                    <PhotoAlbumsRouter />
                </Route>
                <Route path="/commissions">
                    <CommissionsRouter />
                </Route>
                <Route path="/results">
                    <ResultsRouter />
                </Route>
                <Route path="/pages">
                    <PagesRouter />
                </Route>
                <Route path="/users">
                    <UsersRouter />
                </Route>
                <Route path="/agendaitemtypes">
                    <AgendaItemTypesRouter />
                </Route>
                <Route path="/:pagetag">
                    <PagesRouter />
                </Route>
            </Switch>
        </div>
    </Container>
    </Router>;
}

export default AppRouter