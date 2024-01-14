import React from 'react'
import NewObjectComponent from '../Generic/NewObjectComponent'
import { useQueryCache } from 'react-query'
import { useHistory } from 'react-router-dom'
import { createPhotoAlbum } from './queries'
import PhotoAlbumForm from './PhotoAlbumForm'

const NewPhotoAlbum = () => {
  const queryCache = useQueryCache()
  const history = useHistory()
  const onSuccess = (photoAlbum) => {
    queryCache.setQueryData(['photoalbums', photoAlbum.id], photoAlbum)
    history.push(`/photoalbums/${photoAlbum.id}`)
  }

  return (
    <NewObjectComponent
      objectName='photoAlbum'
      createFunction={createPhotoAlbum}
      onSuccess={onSuccess}
      FormComponent={PhotoAlbumForm}
    />
  )
}

export default NewPhotoAlbum
