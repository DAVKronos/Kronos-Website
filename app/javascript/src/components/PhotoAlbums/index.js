import React from "react";
import {Switch, Route} from 'react-router-dom';
import PhotoAlbums from "./PhotoAlbums";
import PhotoAlbum from "./PhotoAlbum";
import Photo from "./Photo";

const PhotoAlbumsRouter = () => {
    return <Switch>
        <Route exact path="/photoalbums" component={PhotoAlbums}/>
        <Route exact path="/photoalbums/:id" component={PhotoAlbum}/>
        <Route path="/photoalbums/:album_id/:photo_id" component={Photo}/>
    </Switch>
};

export default PhotoAlbumsRouter