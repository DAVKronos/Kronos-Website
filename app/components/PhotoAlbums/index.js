import React from 'react'
import { Switch, Route } from 'react-router-dom'
import PhotoAlbums from './PhotoAlbums'
import PhotoAlbum from './PhotoAlbum'
import Photo from './Photo'
import PrivateRoute from '../Generic/PrivateRoute'
import NewPhotoAlbum from './NewPhotoAlbum'
import EditPhotoAlbum from './EditPhotoAlbum'

const PhotoAlbumsRouter = () => {
  return (
    <Switch>
      <Route exact path='/photoalbums' component={PhotoAlbums} />
      <PrivateRoute exact path='/photoalbums/new' action='create' subject='Photoalbum' component={NewPhotoAlbum} />
      <PrivateRoute path='/photoalbums/:id/edit' action='update' subject='Photoalbum' component={EditPhotoAlbum} />
      <Route exact path='/photoalbums/:id' component={PhotoAlbum} />
      <Route path='/photoalbums/:album_id/:photo_id' component={Photo} />
    </Switch>
  )
}

export default PhotoAlbumsRouter
