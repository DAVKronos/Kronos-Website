import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";
import './App.scss';
import Container from 'react-bootstrap/Container'
import Header from "./Header/Header";
import HomePage from "./HomePage/HomePage";
import Footer from "./Footer/Footer";
import AgendaItemsRouter from "./AgendaItems";
import NewsItemsRouter from "./NewsItems";
import PhotoAlbumsRouter from './PhotoAlbums'
import PagesRouter from './Pages';
import CommissionsRouter from "./Commissions";
import Contact from "./Contact/Contact";
import ResultsRouter from "./Results";
import AuthProvider from "../utils/AuthContext";


const App = () => {
  return <AuthProvider><Router basename={'/app'}><Container>
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
        <Route path="/:pagetag">
          <PagesRouter />
        </Route>
      </Switch>
    </div>
    <Footer />
  </Container>
  </Router>
  </AuthProvider>
};

export default App;